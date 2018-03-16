/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.GroupDao;
import com.namph.dao.ProductDao;
import com.namph.dao.UnitDao;
import com.namph.entity.GroupProduct;
import com.namph.entity.Product;
import com.namph.entity.Unit;
import com.namph.model.BodyEntity;
import com.namph.model.Page;
import com.namph.utils.CONSTANT;
import com.namph.utils.PageUtils;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author namph
 */
@Controller
@RequestMapping(value = "/products")
public class ProductsController {

    @Autowired
    private ProductDao productDao;
    @Autowired
    private UnitDao unitDao;
    @Autowired
    private GroupDao gProductDao;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String init(Model model) {
         model.addAttribute("titlePage", "Sản phẩm");
        model.addAttribute("lblTitle", "Thêm mới sản phẩm");
        model.addAttribute("lstUnit", unitDao.getListUnit(new Unit()));
        model.addAttribute("lstType", gProductDao.getListProduct(new GroupProduct()));
        return "categories/products/view";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session, @RequestBody Product product, Model model) {
        int totalRows = productDao.getCount(product);
        List<Product> lstBank = productDao.getListProduct(product);
        model.addAttribute("lstResult", lstBank);
        Page pageInfo = PageUtils.paging(totalRows, product.getPageCurrent(), product.getPageSize());
        model.addAttribute("pageInfo", pageInfo);
        return new ModelAndView("categories/products/search-result");
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody
    String onCreate(HttpSession session, @RequestBody Product product) {
        product.setUnit(new Unit(product.getUnitId()));
        product.setGroup(new GroupProduct(product.getTypeId()));
        product.setStatus(1);
        product.setUserId(1);
        int rs = 0;
        rs = productDao.addProduct(product);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json2 = gson.toJson(new String(rs + ""));
        return json2;
    }

    @RequestMapping(value = "/prepareEdit", method = RequestMethod.POST,
            produces = "application/json; charset=utf-8")
    public @ResponseBody
    String prepareEdit(HttpSession session, @RequestBody Product product, Model model) {
        Product productObj = new Product();
        try {
            productObj = productDao.getProductByid(product.getId());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String result = gson.toJson(new Product(productObj.getId(), productObj.getCode(),
                productObj.getName(), productObj.getNote(),
                productObj.getPrice(), productObj.getUnit().getId(),
                productObj.getGroup().getId(), productObj.getWeight(), productObj.getPriceAu()));
        return result;
    }

    @RequestMapping(value = "/update_status", method = RequestMethod.POST)
    public @ResponseBody
    String onLockUnLock(HttpSession session, @RequestBody Product product, Model model) {
        String result = "";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            productDao.editProduct(product);
            result = CONSTANT.SUCCESS;
        } catch (Exception ex) {
            result = CONSTANT.ERROR;
        }

        return gson.toJson(result);
    }

    @RequestMapping(value = "/getbycode", method = RequestMethod.POST)
    public @ResponseBody
    String loadByCode(HttpSession session, @RequestParam(value = "code") String code) {
        String json2 = "";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        try {
            Product product = new Product();
            product.setCode(code);
            product.setStatus(1);
            List<Product> lst = productDao.getListProduct(product);
            List<BodyEntity> lstBody = new ArrayList<BodyEntity>();
            for (Product obj : lst) {
                BodyEntity entity = new BodyEntity(obj.getId(), obj.getCode(), obj.getName());
                lstBody.add(entity);
            }
            json2 = gson.toJson(lstBody);
        } catch (Exception e) {
        }

        return json2;
    }

}
