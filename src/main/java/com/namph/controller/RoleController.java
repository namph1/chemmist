/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.MenuDao;
import com.namph.dao.RoleDao;
import com.namph.entity.Menu;
import com.namph.entity.MenuAction;
import com.namph.entity.Roles;
import com.namph.model.Page;
import com.namph.utils.CONSTANT;
import com.namph.utils.PageUtils;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
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
@RequestMapping(value = "system/role")
public class RoleController {

    @Autowired
    private RoleDao roleDao;
    @Autowired
    private MenuDao menuDao;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String init(Model model) {
         model.addAttribute("titlePage", "Nhóm quyền");
        return "categories/role/view";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session, @RequestBody Roles role, Model model) {
        int totalRows = roleDao.getCount(role);
        List<Roles> lstRole = roleDao.getListRoles(role);
        model.addAttribute("lstResult", lstRole);
        Page pageInfo = PageUtils.paging(totalRows, role.getPageCurrent(), role.getPageSize());
        model.addAttribute("pageInfo", pageInfo);

        return new ModelAndView("categories/role/search-result");
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody
    String onAdd(HttpSession session, @RequestBody Roles role, Model model) {
        String result = "";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (role.getRoleId() == null) {
                roleDao.insertRole(role);
            } else {
                Roles roleOld = roleDao.getRoleById(role);
                roleOld.setName(role.getName().toUpperCase());
                roleOld.setNote(role.getNote());
                roleDao.updateRole(roleOld);
            }
            result = CONSTANT.SUCCESS;
        } catch (Exception ex) {
            result = CONSTANT.ERROR;
        }
        return gson.toJson(result);
    }

    @RequestMapping(value = "/prepareConfig", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView prepareAssign(HttpSession session, @RequestBody Roles role, Model model) {
        Set<Menu> setMenuOfRole = menuDao.getListMenuByRole(role.getRoleId());
        Set<MenuAction> setActionOfRole = roleDao.getRoleById(role).getMenusAction();
        List<Menu> allmenu = menuDao.getAllMenu();
        model.addAttribute("allMenu", allmenu);
        List<String> lstIds = new ArrayList<>();
        List<String> lstIdsAct = new ArrayList<>();
        if (!setMenuOfRole.isEmpty()) {
            for (Menu menu : setMenuOfRole) {
                lstIds.add(menu.getId().toString());
            }
        }
        if (!setActionOfRole.isEmpty()) {
            for (MenuAction act : setActionOfRole) {
                lstIdsAct.add(act.getMenus().getMenu().getId() + "--" + act.getMenus().getId() + "--" + act.getId());
            }
        }
        model.addAttribute("menus", new Gson().toJson(lstIds));
        model.addAttribute("acts", new Gson().toJson(lstIdsAct));

        return new ModelAndView("categories/role/assign");
    }

    @RequestMapping(value = "/ass", method = RequestMethod.POST)
    public @ResponseBody
    String onAssign(HttpSession session, @RequestBody Roles role, Model model) {
        String result = "";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (!role.getLstIdsMenu().isEmpty()) {
                roleDao.assignMenu(role);
            }
            result = CONSTANT.SUCCESS;
        } catch (Exception ex) {
            result = CONSTANT.ERROR;
        }
        return gson.toJson(result);
    }
}
