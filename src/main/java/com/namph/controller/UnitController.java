/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.UnitDao;
import com.namph.entity.Unit;
import com.namph.model.Page;
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
@RequestMapping(value = "/unit")
public class UnitController {

    @Autowired
    private UnitDao unitDao;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String init(Model model) {
        List<Unit> lstUnit = unitDao.getListUnit(new Unit());
        model.addAttribute("listUnit", lstUnit);
         model.addAttribute("titlePage", "Đơn vị");
        return "categories/unit/view";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session, @RequestBody Unit unit, Model model) {
        int totalRows = unitDao.getCount(unit);
        List<Unit> lstBank = unitDao.getListUnit(unit);
        model.addAttribute("lstBank", lstBank);
        model.addAttribute("lstResult", lstBank);

        Page pageInfo = PageUtils.paging(totalRows, unit.getPageCurrent(), unit.getPageSize());
        model.addAttribute("pageInfo", pageInfo);

        return new ModelAndView("categories/unit/search-result");
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody
    String onCreate(HttpSession session, @RequestBody Unit unit) {
        int rs = 0;
        if (unit.getId() != null) {
            rs = unitDao.edit(unit);
        } else {
            rs = unitDao.add(unit);
        }
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json2 = gson.toJson(new String(rs + ""));
        return json2;
    }
}
