/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.namph.dao.UserDao;
import com.namph.entity.MyUser;
import com.namph.entity.Roles;
import com.namph.model.Page;
import com.namph.utils.CONSTANT;
import com.namph.utils.PageUtils;
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
@RequestMapping(value = "system/user")
public class UserController {

    @Autowired
    private UserDao userDao;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String init(Model model) {
         model.addAttribute("titlePage", "Người dùng");
        return "categories/user/view";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView onSearch(HttpSession session, @RequestBody MyUser user, Model model) {
        int totalRows = userDao.getCount(user);
        List<MyUser> lstUser = userDao.getListUser(user);
        model.addAttribute("lstResult", lstUser);
        Page pageInfo = PageUtils.paging(totalRows, user.getPageCurrent(), user.getPageSize());
        model.addAttribute("pageInfo", pageInfo);

        return new ModelAndView("categories/user/search-result");
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody
    String onAdd(HttpSession session, @RequestBody MyUser user, Model model) {
        String result = "";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            if (user.getUserId() == null) {
                user.setActive(1);
                user.setIsAdmin(0);
                user.setPosition(CONSTANT.USER);
                userDao.addUser(user);
            } else {
                MyUser userOld = userDao.getUserById(user);
                userOld.setName(user.getName());
                userOld.setFullName(user.getFullName());
                userOld.setEmail(user.getEmail());
                userOld.setPhone(user.getPhone());
                userDao.editUser(userOld);
            }
            result = CONSTANT.SUCCESS;
        } catch (Exception ex) {
            result = CONSTANT.ERROR;
        }
        return gson.toJson(result);
    }

    @RequestMapping(value = "/prepareConfig", method = RequestMethod.POST,
            produces = MediaType.TEXT_HTML_VALUE, consumes = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView prepareAssign(HttpSession session, @RequestBody MyUser user, Model model) {
        Set<Roles> lstCusNotAss = userDao.getRolesUser(user);
        List<Roles> setCusOfEmp = userDao.getAllRoles(user);
        model.addAttribute("lstOfEmp", lstCusNotAss);
        model.addAttribute("lstNoAss", setCusOfEmp);
        return new ModelAndView("categories/user/assign");
    }
    
     @RequestMapping(value = "/ass", method = RequestMethod.POST)
    public @ResponseBody
    String onAssign(HttpSession session, @RequestBody MyUser user, Model model) {
        String result = "";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        try {
            userDao.assignRole(user);
            result = CONSTANT.SUCCESS;
        } catch (Exception ex) {
            ex.printStackTrace();
            result = CONSTANT.ERROR;
        }
        return gson.toJson(result);
    }
}
