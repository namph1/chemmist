/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.ChedoDao;
import com.namph.entity.CheDo;
import com.namph.model.Page;
import com.namph.utils.PageUtils;
import com.namph.utils.Utils;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author namph
 */
@Controller
@RequestMapping(value = "/vina")
public class VinaController {

    
    @Autowired
    private ChedoDao chedoDao;

    @RequestMapping(value = "/chedo", method = RequestMethod.GET)
    public String init(Model model) {
        model.addAttribute("titlePage", "Chế độ khách hàng");
        return "vina/chedo/view";
    }

    @RequestMapping(value = "/chedo/search", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session, @RequestBody CheDo chedo, Model model) {
        int totalRows = chedoDao.getCountChedo(chedo);
        List<CheDo> lstBank = chedoDao.getListChedo(chedo);
        model.addAttribute("lstResult", lstBank);
        Page pageInfo = PageUtils.paging(totalRows, chedo.getPageCurrent(), chedo.getPageSize());
        model.addAttribute("pageInfo", pageInfo);

        return new ModelAndView("vina/chedo/search-result");
    }

    @RequestMapping(value = "/chedo/upload", method = RequestMethod.POST)
    public @ResponseBody
    String uploadMultipleFileHandler(@RequestParam("file") MultipartFile excelfile) {
        try {
            Workbook workbook = new XSSFWorkbook(excelfile.getInputStream());
            Sheet worksheet = workbook.getSheetAt(0);
            int i = 0;
            List<CheDo> lstObjectCd = new ArrayList<CheDo>();
            while (i <= worksheet.getLastRowNum()) {
                Row row = worksheet.getRow(i++);
                CheDo chedo = new CheDo();
                chedo.setCode(row.getCell(1).getStringCellValue().toUpperCase());
                chedo.setName(row.getCell(2).getStringCellValue().toUpperCase());
                chedo.setContent(row.getCell(4).getStringCellValue());
                chedo.setStatus(1);
                chedo.setInsertDate(Utils.getTimeVN());
                chedo.setUpdateDate(Utils.getTimeVN());
                try {
                    Double money = row.getCell(3).getNumericCellValue();
                    chedo.setMoney(money.intValue());
                } catch (Exception e) {
                }
                lstObjectCd.add(chedo);
            }
            chedoDao.insertChedo(lstObjectCd);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String strMsg = "";

        return gson.toJson(1);
    }
    
    
    @RequestMapping(value = "/chedo/lockUnlock", method = RequestMethod.POST)
    public @ResponseBody
    String onLockUnLock(HttpSession session, @RequestBody CheDo chedo, Model model) {
        String result = "";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            CheDo cheDodb = chedoDao.getCheDo(chedo.getId());
            cheDodb.setStatus(chedo.getStatus());
            chedoDao.updateChedo(cheDodb);
            result = "Success";
        } catch (Exception ex) {
            result = "Error";
        }
        return gson.toJson(result);
    }
    
    
    @RequestMapping(value = "/chedo/add", method = RequestMethod.POST)
    public @ResponseBody
    String onAdd(HttpSession session, @RequestBody CheDo chedo, Model model) {
        String result = "";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (chedo.getId() == null) {
                chedo.setStatus(1);
                chedo.setInsertDate(Utils.getTimeVN());
                chedo.setUpdateDate(Utils.getTimeVN());
                chedoDao.insertOneCheDo(chedo);
            } else {
                CheDo chedoNew = chedoDao.getCheDo(chedo.getId());
                chedoNew.setCode(chedo.getCode().toUpperCase());
                chedoNew.setName(chedo.getName().toUpperCase());
                chedoNew.setContent(chedo.getContent());
                chedoNew.setStatus(1);
                chedoNew.setInsertDate(Utils.getTimeVN());
                chedoNew.setUpdateDate(Utils.getTimeVN());
                chedoDao.updateChedo(chedoNew);
            }
             result = "Success";
        } catch (Exception ex) {
            ex.printStackTrace();
            result = "Error";
        }
        return gson.toJson(result);
    }
}
