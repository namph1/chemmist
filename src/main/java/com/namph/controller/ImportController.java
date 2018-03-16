/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.CustomerDao;
import com.namph.dao.ImportDao;
import com.namph.dao.ProductDao;
import com.namph.entity.Customer;
import com.namph.entity.Import;
import com.namph.entity.ImportDetail;
import com.namph.entity.Product;
import com.namph.model.Page;
import com.namph.model.UserCustomImpl;
import com.namph.utils.CONSTANT;
import com.namph.utils.PageUtils;
import com.namph.utils.Utils;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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
@RequestMapping(value = "/import")
public class ImportController {

    @Autowired
    private ImportDao importDao;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private CustomerDao customerDao;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String init(Model model) {
        List<Customer> lstCustomer = customerDao.getListCustomer(new Customer(null, null, null, 1, 2));
        model.addAttribute("lstCustomer", lstCustomer);
        model.addAttribute("titlePage", "Nhập hàng");
        return "khohang/nhapkho/view";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST, produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session, @RequestBody Import imp, Model model) {
        int totalRows = importDao.getCount(imp);
        List<Import> lstImp = importDao.getListImport(imp);
        model.addAttribute("lstResult", lstImp);

        Page pageInfo = PageUtils.paging(totalRows, imp.getPageCurrent(), imp.getPageSize());
        model.addAttribute("pageInfo", pageInfo);
        return new ModelAndView("khohang/nhapkho/search-result");
    }

    @RequestMapping(value = "/put/{code}", method = RequestMethod.POST, produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onPut(HttpSession session, @PathVariable("code") String code,
            @RequestBody Product[] arrProduct, Model model) {
        LinkedList<Product> lstProducts = new LinkedList<Product>();
        List<Product> lstProdutSearch = productDao.getListProduct(new Product(code.trim()));
        if (lstProdutSearch.isEmpty()) {
            model.addAttribute("error", "Không tìm thấy sản phẩm");
        }
        int count = 0;
        if (arrProduct != null && arrProduct.length > 0) {
            boolean flag = false;
            for (Product arrProduct1 : arrProduct) {
                Product product = productDao.getProductByid(arrProduct1.getId());
                product.setCount(arrProduct1.getCount());
                product.setPrice(arrProduct1.getPrice());
                lstProducts.add(product);
                if (arrProduct1.getCode().equalsIgnoreCase(code.trim())) {
                    flag = true;
                }
                count += arrProduct1.getCount();
            }
            if (!flag && !lstProdutSearch.isEmpty()) {
                Product productSearch = lstProdutSearch.get(0);
                productSearch.setPrice(productSearch.getPriceAu());
                lstProducts.add(productSearch);
            } else if (flag) {
                model.addAttribute("error", "Sản phẩm đã được thêm");
            }
            model.addAttribute("total_count", count);
            model.addAttribute("total_price", 0f);
            model.addAttribute("total_weight", 0f);
        } else {
            if (!lstProdutSearch.isEmpty()) {
                Product productSearch = lstProdutSearch.get(0);
                productSearch.setPrice(productSearch.getPriceAu());
                lstProducts.add(productSearch);
            }
            model.addAttribute("total_count", count);
            model.addAttribute("total_price", 0f);
            model.addAttribute("total_weight", 0f);
        }
        model.addAttribute("lstProduct", lstProducts);

        return new ModelAndView("khohang/nhapkho/table_detail");
    }

    @RequestMapping(value = "/del/{id}", method = RequestMethod.POST, produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onDel(HttpSession session, @PathVariable("id") Integer id,
            @RequestBody Product[] arrProduct, Model model) {
        LinkedList<Product> lstProducts = new LinkedList<Product>();
        if (arrProduct != null && arrProduct.length > 0) {
            for (int i = 0; i < arrProduct.length; i++) {
                Product product = productDao.getProductByid(arrProduct[i].getId());
                product.setCount(arrProduct[i].getCount());
                lstProducts.add(product);
            }
        }
        model.addAttribute("lstProduct", lstProducts);

        return new ModelAndView("khohang/nhapkho/table_detail");
    }

    @RequestMapping(value = "/prepareAdd", method = RequestMethod.POST, produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView prepareAdd(HttpSession session, Model model, @RequestBody Import imp) {
        LinkedList<Product> lstProducts = new LinkedList<Product>();
        int count = 0;
        if (imp.getId() == null) {
            model.addAttribute("lstProduct", lstProducts);
            model.addAttribute("total_count", count);
            model.addAttribute("total_price", 0f);
            model.addAttribute("total_weight", 0f);
        } else {
            imp = importDao.getImpById(imp);
            List<ImportDetail> lst = imp.getLstDetail();

            if (!lst.isEmpty()) {
                for (ImportDetail detail : lst) {
                    Product product = detail.getProduct();
                    product.setCount(detail.getCount());
                    product.setPrice(detail.getPrice());
                    lstProducts.add(product);
                    count += detail.getCount();
                }
            }
            model.addAttribute("error", imp.getStrCreateDate().split("\\s")[0]);
            model.addAttribute("lstProduct", lstProducts);
            model.addAttribute("total_price", imp.getTotalPrice());
            model.addAttribute("total_weight", imp.getWeight());
            model.addAttribute("total_count", count);
        }
        return new ModelAndView("khohang/nhapkho/table_detail");
    }

    @RequestMapping(value = "/add/{curr}", method = RequestMethod.POST, produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    ModelAndView onAdd(HttpSession session, @PathVariable("curr") String curr,
            @RequestBody Product[] arrProduct, Model model) {
        String result = "";
        try {
            if (arrProduct != null && arrProduct.length > 0) {
                Import imp = new Import();
                imp.setStrCreateDate("01" + curr.replaceAll("-", "/").substring(2, 10));
                imp.setCustomer(new Customer(arrProduct[0].getUserId()));
                imp.setFeeShip(arrProduct[0].getTotal());
                imp.setRate(arrProduct[0].getPriceAu());
                int maxNo = importDao.getMaxNoByMonth(imp) + 1;
                Date createdDate = Utils.getTimeVN();
                List<ImportDetail> lstDetail = new ArrayList<>();
                Float weight = 0f;
                Float price = 0f;
                for (Product arrProduct1 : arrProduct) {
                    ImportDetail detail = new ImportDetail();
                    detail.setProduct(new Product(arrProduct1.getId()));
                    detail.setCount(Float.valueOf(arrProduct1.getCount().toString()));
                    detail.setCreatedDate(createdDate);
                    detail.setPrice(arrProduct1.getPrice());
                    detail.setImp(imp);
                    lstDetail.add(detail);
                    weight += (detail.getCount() * Float.valueOf(arrProduct1.getWeight().toString()));
                    price += (detail.getCount() * arrProduct1.getPrice());
                }
                UserCustomImpl user = (UserCustomImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
                imp.setUsers(user.getUsers());
                imp.setTotalPrice(price);
                imp.setTotal(price + arrProduct[0].getTotal());
                imp.setNo(maxNo);
                imp.setWeight(weight);
                imp.setCreatedDate(createdDate);
                imp.setLstDetail(lstDetail);
                importDao.insertImp(imp);

                result = CONSTANT.SUCCESS;
            } else {
                throw new Exception();
            }
        } catch (Exception ex) {
            result = CONSTANT.ERROR;
        }

        model.addAttribute("message", result);
        return new ModelAndView("khohang/nhapkho/search-result");
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public @ResponseBody
    String onDelete(HttpSession session, @RequestBody Import imp) {
        int rs = 0;
        rs = importDao.deleteImp(imp);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json2 = gson.toJson(new String(rs + ""));
        return json2;
    }
}
