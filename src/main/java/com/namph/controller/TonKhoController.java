/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.ImportDao;
import com.namph.dao.TonKhoDao;
import com.namph.entity.Import;
import com.namph.entity.ImportDetail;
import com.namph.entity.Product;
import com.namph.model.Page;
import com.namph.model.TonKho;
import com.namph.utils.ExcelBuilder;
import com.namph.utils.PageUtils;
import com.namph.utils.Utils;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang.time.DateUtils;
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
@RequestMapping(value = "/tonkho")
public class TonKhoController {

    @Autowired
    private TonKhoDao tonkhoDao;
    @Autowired
    private ImportDao importDao;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String init(Model model) {
        return "khohang/tonkho/view";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST, produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session, @RequestBody TonKho tonkho, Model model) {
        List<TonKho> lstImp = tonkhoDao.getListTonKho(tonkho.getFromDate(), tonkho.getToDate());
        int totalRows = lstImp.size();
        model.addAttribute("lstResult", lstImp);

        Page pageInfo = PageUtils.paging(totalRows, tonkho.getPageCurrent(), tonkho.getPageSize());
        model.addAttribute("pageInfo", pageInfo);
        return new ModelAndView("khohang/tonkho/search-result");
    }

    @RequestMapping(value = "/exportExcel", method = RequestMethod.GET)
    public ModelAndView exportExcel(HttpServletResponse response,
            @RequestParam("to") String to, @RequestParam("from") String from) {
        response.setHeader("Content-disposition", "attachment; filename=" + "BC_xuat_nhap_ton_sanpham" + ".xls");
        String[] titles = {"Mã sản phẩm", "Tên sản phẩm", "Đơn vị", "Tồn đầu kỳ(số lượng)", "Nhập kho(số lượng)", "Xuất kho(số lượng)", "Tồn cuối kỳ(số lượng)"};
        List<TonKho> lstImp = tonkhoDao.getListTonKho(from, to);
        List<Map<Integer, Object>> lstData = new LinkedList<>();
        for (TonKho obj : lstImp) {
            Map<Integer, Object> map = new HashMap<>();
            map.put(1, obj.getProductCode());
            map.put(2, obj.getProductName());
            map.put(3, obj.getUnitName());
            map.put(4, obj.getTondauky());
            map.put(5, obj.getSanluong());
            map.put(6, obj.getSanluongXuat());
            map.put(7, obj.getCount());
            lstData.add(map);
        }
        return new ModelAndView(new ExcelBuilder("listBooks", "sheet1",
                "Báo cáo tồn kho sản phẩm từ " + from + " tới " + to, titles), "listBooks", lstData);
    }

    @RequestMapping(value = "/chotton", method = RequestMethod.POST)
    public @ResponseBody
    String onCreate(HttpSession session, @RequestBody TonKho tonkho) {
        int rs = 0;
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, Integer.valueOf(tonkho.getFromDate().split("\\/")[0]) -1);
        calendar.set(Calendar.YEAR, Integer.valueOf(tonkho.getFromDate().split("\\/")[1]));
        
        String from = "01/" + tonkho.getFromDate();
        String to = calendar.getActualMaximum(Calendar.DATE) + "/" + tonkho.getFromDate();

        Date newDate = DateUtils.addMonths(Utils.stringDDMMYYY2Date(from), 1);
        Date secondDate = DateUtils.addDays(newDate, 1);
        
        List<TonKho> lstCongNoCuoiKy = tonkhoDao.getListTonKho(from, to);
        importDao.deleteImpDauKy(newDate, secondDate);
        rs = insertTonKhoDauKy(lstCongNoCuoiKy,newDate);
        String json2 = gson.toJson(new String(rs + ""));
        return json2;
    }

    private int insertTonKhoDauKy(List<TonKho> lstCongNoCuoiKy, Date date) {
        List<ImportDetail> lstDetail = new ArrayList<>();
        Import imp = new Import();
        Date createdDate = Utils.getFirstDayOfCurrentMonth(false);
        for (TonKho arrProduct1 : lstCongNoCuoiKy) {
            ImportDetail detail = new ImportDetail();
            detail.setProduct(new Product(arrProduct1.getProductId()));
            detail.setCount(Float.valueOf(arrProduct1.getCount().toString()));
            detail.setCreatedDate(date);
            detail.setType(0);
            detail.setImp(imp);
            lstDetail.add(detail);
        }

        imp.setNo(0);
        imp.setCreatedDate(date);
        imp.setLstDetail(lstDetail);
        importDao.insertImp(imp);
        return Integer.MAX_VALUE;
    }
}
