/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.CustomerDao;
import com.namph.dao.MoneyDao;
import com.namph.entity.Customer;
import com.namph.entity.Money;
import com.namph.model.Page;
import com.namph.utils.PageUtils;
import com.namph.utils.Utils;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author namph
 */
@Controller
public class MoneyController {

    @Autowired
    private MoneyDao moneyDao;
    @Autowired
    private CustomerDao customerDao;

    @RequestMapping(value = "/cash", method = RequestMethod.GET)
    public String initCash(Model model) {
        List<Customer> lstCus = customerDao.getListCustomer(new Customer(null, 1));
        model.addAttribute("lstCust", lstCus);
         model.addAttribute("titlePage", "Tài chính");
        return "taichinh/cash/view";
    }

    @RequestMapping(value = "/cash/search", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session, @RequestBody Money money, Model model) {

        //set type = 1 --> cash
        money.setType(1);

        int totalRows = moneyDao.getCount(money);
        List<Money> lstMoney = moneyDao.getListMoney(money);
        Double totalIn = 0d;
        Double totalOut = 0d;
        if (money.getStatus() == -1) {
            money.setStatus(0);
            totalIn = moneyDao.getTotal(money);
            money.setStatus(1);
            totalOut = moneyDao.getTotal(money);
        } else {
            if (money.getStatus().equals(0)) {
                totalIn = moneyDao.getTotal(money);
            } else if (money.getStatus().equals(1)) {
                totalOut = moneyDao.getTotal(money);
            }
        }

        model.addAttribute("totalOut", totalOut == null ? 0 : totalOut);
        model.addAttribute("totalIn", totalIn == null ? 0 : totalIn);
        model.addAttribute("lstResult", lstMoney);

        Page pageInfo = PageUtils.paging(totalRows, money.getPageCurrent(), money.getPageSize());
        model.addAttribute("pageInfo", pageInfo);

        return new ModelAndView("taichinh/cash/search-result");
    }

    @RequestMapping(value = "/cash/add", method = RequestMethod.POST)
    public @ResponseBody
    String onCreate(HttpSession session, @RequestBody Money money) {
        int rs = 0;
        if (money.getId() != null) {
            Money mone = moneyDao.getMoneyById(money);
            if (money.getCustomerId() != null) {
                money.setCustomer(new Customer(money.getCustomerId()));
            }
            mone.setNote(money.getNote());
            mone.setTotal(money.getTotal());
            rs = moneyDao.edittMoney(mone);
        } else {
            try {

                if (money.getCustomerId() != null) {
                    money.setCustomer(new Customer(money.getCustomerId()));
                }
                money.setNo(moneyDao.getMaxNoOfCurMonthByTypeByStatus(new Money(1, money.getStatus())) + 1);
                money.setType(1);
                money.setCreatedDate(Utils.getTimeVN());
                rs = moneyDao.insertMoney(money);
            } catch (Exception e) {
            }
        }
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json2 = gson.toJson(rs > 0 ? "Thành công" : "Thất bại");
        return json2;
    }

    @RequestMapping(value = "/cash/delete", method = RequestMethod.POST)
    public @ResponseBody
    String onDelete(HttpSession session, @RequestBody Money money) {
        int rs = 0;
        rs = moneyDao.deleteMoney(money);
        String json2 = rs + "";
        return json2;
    }

}
