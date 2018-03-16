/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.GroupDao;
import com.namph.entity.GroupProduct;
import com.namph.entity.MenuAction;
import com.namph.model.Page;
import com.namph.model.UserCustomImpl;
import com.namph.utils.PageUtils;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author namph
 */
@Controller
@RequestMapping(value = "/g_product")
public class GroupProductController {

    @Autowired
    private GroupDao gProductDao;

    private List<MenuAction> lstAct = new ArrayList<MenuAction>();

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String init(Model model, HttpServletRequest request) {
        String pattern = (String) request.getAttribute(
                HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);
        List<MenuAction> lstMenuAction = new ArrayList<>();
        lstMenuAction = (List<MenuAction>) request.getSession().getAttribute("actionmenu");
        if (lstMenuAction != null && !lstMenuAction.isEmpty()) {
            lstAct.clear();
            for (MenuAction action : lstMenuAction) {
                if (("/" + action.getMenus().getUrl()).equals(pattern)) {
                    lstAct.add(action);
                }
            }
        }
        model.addAttribute("lstAct", lstAct);
        model.addAttribute("titlePage", "Nhóm sản phẩm");
        return "categories/group_product/view";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session, @RequestBody GroupProduct group, Model model) {
        int totalRows = gProductDao.getCount(group);
        List<GroupProduct> lstBank = gProductDao.getListProduct(new GroupProduct());
        model.addAttribute("lstResult", lstBank);
        Page pageInfo = PageUtils.paging(totalRows, group.getPageCurrent(), group.getPageSize());
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("lstAct", lstAct);

        return new ModelAndView("categories/group_product/search-result");
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody
    String onCreate(HttpSession session, @RequestBody GroupProduct group) {
        int rs = 0;
        group.setStatus(1);
        UserCustomImpl user = (UserCustomImpl) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        group.setUserId(user.getUserId());
        if (group.getId() != null) {
            rs = gProductDao.edit(group);
        } else {
            group.setCreatedDate(new Date());
            rs = gProductDao.add(group);
        }
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json2 = gson.toJson(new String(rs + ""));
        return json2;
    }

    @RequestMapping(value = "/del", method = RequestMethod.POST)
    public @ResponseBody
    String onDel(HttpSession session, @RequestBody GroupProduct group) {
        int rs = 0;
        group = gProductDao.getGroup(group);
        group.setStatus(0);
        rs = gProductDao.edit(group);
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        String json2 = gson.toJson(new String(rs + ""));
        return json2;
    }
}
