/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.CustomerDao;
import com.namph.dao.ProductDao;
import com.namph.dao.UnitDao;
import com.namph.entity.Customer;
import com.namph.entity.Product;
import com.namph.entity.Unit;
import com.namph.model.Page;
import com.namph.utils.CONSTANT;
import com.namph.utils.PageUtils;
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
@RequestMapping(value = "/customer")
public class CustomerController {

    @Autowired
    private CustomerDao customerDao;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private UnitDao unitDao;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String init(Model model) {
        model.addAttribute("titlePage", "Khách hàng- Đại lý");
        return "categories/customer/view";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session, @RequestBody Customer customer, Model model) {
        int totalRows = customerDao.getCount(customer);
        List<Customer> lstBank = customerDao.getListCustomer(customer);
        model.addAttribute("lstResult", lstBank);
        Page pageInfo = PageUtils.paging(totalRows, customer.getPageCurrent(), customer.getPageSize());
        model.addAttribute("pageInfo", pageInfo);

        return new ModelAndView("categories/customer/search-result");
    }

    @RequestMapping(value = "/lockUnlock", method = RequestMethod.POST)
    public @ResponseBody
    String onLockUnLock(HttpSession session, @RequestBody Customer customer, Model model) {
        String result = "";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            customerDao.edit(customer);
            result = CONSTANT.SUCCESS;
        } catch (Exception ex) {
            result = CONSTANT.ERROR;
        }
        return gson.toJson(result);
    }




    private void reloadData(Model model, Integer customerId) {
        Customer customerObj = customerDao.getCustomerById(customerId, false);

        List<Product> lstProduct = productDao.getListProduct(new Product());

//        List<CustomerProductUnit> lst = customerObj.getLstCustomer();
//
//        Map<Integer, CustomerProductUnit> map1 = new HashMap<>();
//
//        for (Product obj : lstProduct) {
//            CustomerProductUnit objc = new CustomerProductUnit(obj.getPrice(), customerObj,
//                    obj.getUnit(), obj);
//            map1.put(obj.getId(), objc);
//        }
//
//        if (!lst.isEmpty()) {
//            for (CustomerProductUnit obj : lst) {
//                map1.put(obj.getProduct().getId(), obj);
//            }
//        }

        model.addAttribute("lstUnit", unitDao.getListUnit(new Unit()));
//        model.addAttribute("lstProduct", map1);
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody
    String onAdd(HttpSession session, @RequestBody Customer customer, Model model) {
        String result = "";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (customer.getId() == null) {
                customer.setCode(PageUtils.generateCodeCus(customer.getName()));
                customerDao.edit(customer);
            } else {
                Customer cusDb = customerDao.getCustomerById(customer.getId(), true);
                cusDb.setCode(PageUtils.generateCodeCus(customer.getName()));
                cusDb.setName(customer.getName());
                cusDb.setPhone(customer.getPhone());
                cusDb.setAddress(customer.getAddress());
                cusDb.setStatus(null);// set null vi trong dao se set lai
                customerDao.edit(cusDb);
            }
            result = CONSTANT.SUCCESS;
        } catch (Exception ex) {
            ex.printStackTrace();
            result = CONSTANT.ERROR;
        }
        return gson.toJson(result);
    }


}
