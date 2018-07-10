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
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
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
        exp.setFromDate(Utils.Date2DDMMYYYYH24MI(Utils.getFirstDayOfCurrentYear(true)));
        exp.setToDate(Utils.Date2DDMMYYYYH24MI(Utils.getLastDayOfCurrentYear()));
        model.addAttribute("sizeExp", exportDao.getCountFromTo(exp));
        model.addAttribute("sizeCus", customerDao.getCount(new Customer(null, null, null, null, 1)));
        Money money = new Money();
        money.setFromDate(Utils.Date2DDMMYYYYH24MI(Utils.getFirstDayOfCurrentYear(true)));
        money.setToDate(Utils.Date2DDMMYYYYH24MI(Utils.getLastDayOfCurrentYear()));
        money.setType(1);
        money.setStatus(0);
        Double dMoney = moneyDao.getTotal(money);
        model.addAttribute("sizeMoney", dMoney == null ? 0 : dMoney);
        money.setStatus(1);
        dMoney = moneyDao.getTotal(money);
        model.addAttribute("sizeMoney2", dMoney == null ? 0 : dMoney);
        model.addAttribute("sizeOline", sessionRegistry.getAllPrincipals().size());
        model.addAttribute("sizeProduct", productDao.getCount(new Product(null, null, 1)));
        try {
            JSONObject json = readJsonFromUrl("http://dongabank.com.vn/exchange/export");
            JSONArray jsonArr = json.getJSONArray("items");
            Iterator itr = jsonArr.iterator();
            while (itr.hasNext()) {
                JSONObject obj = (JSONObject) itr.next();
                if (obj.get("type").toString().equals("AUD")) {
                    model.addAttribute("obj", obj);
                    break;
                }
            }
        } catch (Exception e) {
        }
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

    private static String readAll(Reader rd) throws IOException {
        StringBuilder sb = new StringBuilder();
        int cp;
        while ((cp = rd.read()) != -1) {
            sb.append((char) cp);
        }
        return sb.toString().replace("(", "").replace(")", "");
    }

    public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
        InputStream is = new URL(url).openStream();
        try {
            BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            String jsonText = readAll(rd);
            JSONObject json = new JSONObject(jsonText);
            return json;
        } finally {
            is.close();
        }
    }

    public static void main(String[] args) {
        JSONObject json;
        try {
            json = readJsonFromUrl("http://dongabank.com.vn/exchange/export");
            JSONArray jsonArr = json.getJSONArray("items");
            JSONObject obj = jsonArr.getJSONObject(1);
            System.out.println(obj.get("type"));
        } catch (IOException ex) {
            Logger.getLogger(MainController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JSONException ex) {
            Logger.getLogger(MainController.class.getName()).log(Level.SEVERE, null, ex);
        }
//    System.out.println(json.get("id"));
    }
}
