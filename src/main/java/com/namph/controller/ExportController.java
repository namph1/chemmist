/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.CustomerDao;
import com.namph.dao.ExportDao;
import com.namph.dao.ProductDao;
import com.namph.entity.Customer;
import com.namph.entity.Export;
import com.namph.entity.ExportDetail;
import com.namph.entity.Product;
import com.namph.entity.Unit;
import com.namph.model.Page;
import com.namph.model.UserCustomImpl;
import com.namph.utils.CONSTANT;
import com.namph.utils.PageUtils;
import com.namph.utils.Utils;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.StringUtils;
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
@RequestMapping(value = "/export")
public class ExportController {

    @Autowired
    private ExportDao exportDao;
    @Autowired
    private CustomerDao customerDao;
    @Autowired
    private ProductDao productDao;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String init(Model model) {
        model.addAttribute("titlePage", "Bán hàng");
        return "banhang/xuathang/view";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session,
            @RequestBody Export exp, Model model) throws Exception {
        int totalRows = exportDao.getCount(exp);
        List<Export> lstExp = exportDao.getListByCondition(exp);
        model.addAttribute("lstResult", lstExp);
        Page pageInfo = PageUtils.paging(totalRows, exp.getPageCurrent(), exp.getPageSize());
        model.addAttribute("pageInfo", pageInfo);

        return new ModelAndView("banhang/xuathang/search-result");
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public @ResponseBody
    String onDelete(HttpSession session, @RequestBody Export exp) {
        int rs = 0;
        rs = exportDao.deleteExp(exp);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json2 = gson.toJson(new String(rs + ""));
        return json2;
    }

    @RequestMapping(value = "/prepareAdd", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView prepareAdd(HttpSession session, Model model,
            @RequestBody Export exp) {
        LinkedList<Product> lstProducts = new LinkedList<Product>();
        if (exp.getId() != null) {
            Float total = 0f;
            exp = exportDao.getExpById(exp);
            List<ExportDetail> lstDetail = exp.getLstDetail();
            if (!lstDetail.isEmpty()) {

                for (ExportDetail detail : lstDetail) {
                    Product product = detail.getProduct();
                    product.setExportDetailId(detail.getId());
                    product.setCount(detail.getCount());
                    product.setPrice(detail.getPrice());
                    product.setWeight(detail.getWeight());
                    lstProducts.add(product);
                    total += detail.getCount() * detail.getPrice();
                }
            }

            model.addAttribute("error", exp.getStrCreateDate().split("\\s")[0]);
            model.addAttribute("total", total);
            model.addAttribute("discount", exp.getDiscount());
        } else {
            model.addAttribute("total", 0);
            model.addAttribute("discount", 0);
        }
        List<Customer> lstCustomer = customerDao.getListCustomer(new Customer(null, null, null, 1, 1));
        model.addAttribute("lstCustomer", lstCustomer);
        model.addAttribute("lstProduct", lstProducts);
        return new ModelAndView("banhang/xuathang/form_add");
    }

    private Map<Integer, Product> reloadData(Integer customerId) {
        Customer customerObj = customerDao.getCustomerById(customerId, false);

        List<Product> lstProduct = productDao.getListProduct(new Product());

//        List<CustomerProductUnit> lst = customerObj.getLstCustomer();
        Map<Integer, Product> map1 = new HashMap<>();

        for (Product obj : lstProduct) {
//            CustomerProductUnit objc = new CustomerProductUnit(obj.getPrice(), customerObj,
//                    obj.getUnit(), obj);
            map1.put(obj.getId(), obj);
        }

//        if (!lst.isEmpty()) {
//            for (CustomerProductUnit obj : lst) {
//                Product product = map1.get(obj.getProduct().getId());
//                product.setPrice(obj.getPrice());
//                product.setUnit(obj.getUnit());
//                if (obj.getUnit().getRate() != null && obj.getUnit().getRate() > 0) {
//                    product.setWeight(product.getWeight() * obj.getUnit().getRate());
//                }
//
//                map1.put(obj.getProduct().getId(), product);
//            }
//        }
        return map1;
    }

    @RequestMapping(value = "/put/{code}", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onPut(HttpSession session, @PathVariable("code") String codeCusId,
            @RequestBody Product[] arrProduct, Model model) {
        String[] arrCodeCusId = codeCusId.split("-");
        String code = arrCodeCusId[0].trim();
        String sTotalBefore = arrCodeCusId[2].trim();
        String sDiscount = arrCodeCusId[3].trim();
        LinkedList<Product> lstProducts = new LinkedList<Product>();
        Map<Integer, Product> map1 = reloadData(Integer.valueOf(arrCodeCusId[1]));
        List<Product> lstProdutSearch = productDao.getListProduct(new Product(null, code, 1));
        if (lstProdutSearch.isEmpty() || lstProdutSearch.size() != 1) {
            model.addAttribute("error", "Không tìm thấy sản phẩm! Hãy kiểm tra lại mã sản phẩm");
        } else {
            if (arrProduct != null && arrProduct.length > 0) {
                boolean flag = false;
                for (Product arrProduct1 : arrProduct) {
                    Product product = map1.get(arrProduct1.getId());
                    product.setCount(arrProduct1.getCount());
                    product.setPrice(arrProduct1.getPrice());
                    lstProducts.add(product);
                    if (arrProduct1.getCode().equalsIgnoreCase(code)) {
                        flag = true;
                    }
                }
                if (!flag && !lstProdutSearch.isEmpty()) {
                    Product productSearch = map1.get(lstProdutSearch.get(0).getId());
                    lstProducts.add(productSearch);
                } else if (flag) {
                    model.addAttribute("error", "Sản phẩm đã được thêm");
                }
            } else {
                if (!lstProdutSearch.isEmpty()) {
                    Product productSearch = map1.get(lstProdutSearch.get(0).getId());
                    lstProducts.add(productSearch);
                }
            }
        }
        model.addAttribute("total", sTotalBefore);
        model.addAttribute("discount", sDiscount);
        model.addAttribute("lstProduct", lstProducts);

        return new ModelAndView("banhang/xuathang/table_detail");
    }

    @RequestMapping(value = "/del/{id}", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onDel(HttpSession session, @PathVariable("id") String idTotalDiscount,
            @RequestBody Product[] arrProduct, Model model) {
        LinkedList<Product> lstProducts = new LinkedList<Product>();
//        Float total= 0f;
        if (arrProduct != null && arrProduct.length > 0) {
            for (int i = 0; i < arrProduct.length; i++) {
                Product product = productDao.getProductByid(arrProduct[i].getId());
                product.setCount(arrProduct[i].getCount());
                product.setPrice(arrProduct[i].getPrice());
                lstProducts.add(product);
//                total += arrProduct[i].getCount()* arrProduct[i].getPrice();
            }
        }
        String[] arr = idTotalDiscount.split("_");

//        model.addAttribute("total", total);
        model.addAttribute("discount", arr[2].trim());
        model.addAttribute("lstProduct", lstProducts);

        return new ModelAndView("banhang/xuathang/table_detail");
    }

    @RequestMapping(value = "/add/{curr}", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    ModelAndView onAdd(HttpSession session, @PathVariable("curr") String strInput,
            @RequestBody Product[] arrProduct, Model model) {
        //curr: date_cusId_totalAfter_discount_totalBefore
        String curr = strInput.split("_")[0];
        String result = "";
        try {
            Integer customerId = Integer.valueOf(strInput.split("_")[1].split("-")[0]);
            Customer cus = customerDao.getCustomerById(customerId, false);
            String idExport = "";
            if (strInput.split("_").length == 6) {
                idExport = strInput.split("_")[5];
            }
            UserCustomImpl user = (UserCustomImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            Float weight = 0f;
            if (StringUtils.isEmpty(idExport)) {
                if (arrProduct != null && arrProduct.length > 0) {
                    Export exp = new Export();
                    exp.setStrCreateDate("01" + curr.replaceAll("-", "/").substring(2, 10));
                    int maxNo = exportDao.getMaxNoByMonth(exp) + 1;
                    Date createdDate = Utils.stringDDMMYYY2Date(curr.replaceAll("-", "/"));//new Date();
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(Utils.getTimeVN());
                    Calendar cal1 = Calendar.getInstance();
                    cal1.setTime(createdDate);
                    cal1.set(Calendar.HOUR_OF_DAY, cal.get(Calendar.HOUR_OF_DAY));
                    cal1.set(Calendar.MINUTE, cal.get(Calendar.MINUTE));
                    cal1.set(Calendar.SECOND, cal.get(Calendar.SECOND));
                    createdDate = cal1.getTime();                   
                    
                    List<ExportDetail> lstDetail = new ArrayList<>();
                    for (Product arrProduct1 : arrProduct) {
                        ExportDetail detail = new ExportDetail();
                        detail.setProduct(new Product(arrProduct1.getId()));
                        detail.setCount(Float.valueOf(arrProduct1.getCount().toString()));
                        detail.setCreatedDate(createdDate);
                        detail.setPrice(arrProduct1.getPrice());
                        detail.setExp(exp);
                        detail.setUnit(new Unit(arrProduct1.getUnitId()));
                        detail.setWeight(arrProduct1.getWeight());
                        lstDetail.add(detail);
                        weight += (detail.getCount() * arrProduct1.getWeight());
                    }
                    exp.setUsers(user.getUsers());
                    exp.setWeight(weight);
                    exp.setNo(maxNo);
                    exp.setDiscount(Float.valueOf(strInput.split("_")[3]));
                    exp.setTotal(Float.valueOf(strInput.split("_")[4]));
                    exp.setTotalLast(Float.valueOf(strInput.split("_")[2]));
                    exp.setCustomer(cus);
                    exp.setCreatedDate(createdDate);
                    exp.setLstDetail(lstDetail);

                    exportDao.insertExp(exp);

                    result = CONSTANT.SUCCESS;
                } else {
                    throw new Exception();
                }
            } else {
                try {
                    Integer exportId = Integer.valueOf(idExport);
                    Export exp = exportDao.getExpById(new Export(exportId));
                    Date createdDate = exp.getCreatedDate();
                    List<ExportDetail> lstDetail = new ArrayList<ExportDetail>();
                    for (Product arrProduct1 : arrProduct) {
                        ExportDetail detail = new ExportDetail();
                        if (arrProduct1.getExportDetailId() != null) {
                            detail.setId(arrProduct1.getExportDetailId());
                        }
                        detail.setProduct(new Product(arrProduct1.getId()));
                        detail.setCount(Float.valueOf(arrProduct1.getCount().toString()));
                        detail.setCreatedDate(createdDate);
                        detail.setPrice(arrProduct1.getPrice());
                        detail.setExp(exp);
                        detail.setUnit(new Unit(arrProduct1.getUnitId()));
                        detail.setWeight(arrProduct1.getWeight());
                        lstDetail.add(detail);
                        weight += (detail.getCount() * arrProduct1.getWeight());
                    }
                    exp.setUsers(user.getUsers());
                    exp.setWeight(weight);
                    exp.setDiscount(Float.valueOf(strInput.split("_")[3]));
                    exp.setTotal(Float.valueOf(strInput.split("_")[4]));
                    exp.setTotalLast(Float.valueOf(strInput.split("_")[2]));
                    exp.setCustomer(cus);
                    exp.setLstDetail(lstDetail);
                    exportDao.updateExp(exp);
                    result = CONSTANT.SUCCESS;
                } catch (Exception e) {
                    result = CONSTANT.ERROR;
                }
            }
        } catch (Exception ex) {
            result = CONSTANT.ERROR;
        }

        model.addAttribute("message", result);
        return new ModelAndView("banhang/xuathang/search-result");
    }
}
