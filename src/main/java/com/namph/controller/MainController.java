/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.namph.dao.CustomerDao;
import com.namph.dao.ExportDao;
import com.namph.dao.MoneyDao;
import com.namph.dao.ProductDao;
import com.namph.entity.Customer;
import com.namph.entity.Export;
import com.namph.entity.Money;
import com.namph.entity.Product;
import com.namph.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author namph
 */
@Controller
public class MainController {

    @Autowired
    private MessageSource messageSource;
    @Autowired
    private ExportDao exportDao;
    @Autowired
    private CustomerDao customerDao;
    @Autowired
    private MoneyDao moneyDao;
    @Autowired
    private ProductDao productDao;
    @Autowired
    SessionRegistry sessionRegistry;

    public MessageSource getMessageSource() {
        return messageSource;
    }

    public void setMessageSource(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcomePage(Model model) {
        model.addAttribute("titlePage", "Trang chủ");
        Export exp = new Export();
        exp.setFromDate(Utils.Date2DDMMYYYYH24MI(Utils.getFirstDayOfCurrentMonth(true)));
        exp.setToDate(Utils.Date2DDMMYYYYH24MI(Utils.getLastDayOfCurrentMonth()));
        model.addAttribute("sizeExp", exportDao.getCountFromTo(exp));
        model.addAttribute("sizeCus", customerDao.getCount(new Customer(null, null, null, null, 1)));
        Money money = new Money();
        money.setFromDate(Utils.Date2DDMMYYYYH24MI(Utils.getFirstDayOfCurrentMonth(true)));
        money.setToDate(Utils.Date2DDMMYYYYH24MI(Utils.getLastDayOfCurrentMonth()));
        money.setType(1);
        money.setStatus(0);
        model.addAttribute("sizeMoney", moneyDao.getTotal(money));
        money.setStatus(1);
        model.addAttribute("sizeMoney2", moneyDao.getTotal(money));
        model.addAttribute("sizeOline", sessionRegistry.getAllPrincipals().size());
        model.addAttribute("sizeProduct", productDao.getCount(new Product(null, null, 1)));

        return "home/home";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(Model model) {
        return "loginPage";
    }

    @RequestMapping(value = "/logoutSuccessful", method = RequestMethod.GET)
    public String logoutSuccessfulPage(Model model) {
        model.addAttribute("title", "Logout");
        return "logoutSuccessfulPage";
    }

}
