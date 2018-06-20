/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.controller;

import com.namph.entity.MyUser;
import com.namph.model.UserCustomImpl;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 *
 * @author namph
 */
public class BaseController {
    protected MyUser getUserLogin(){
        UserCustomImpl user = (UserCustomImpl) 
                SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        return user.getUsers();
    }
    
    protected Integer getUserIdLogin(){
        return getUserLogin().getUserId();
    }
}
