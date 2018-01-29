/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.service;

import com.namph.entity.Menu;
import com.namph.model.UserCustomImpl;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.GenericFilterBean;

/**
 *
 * @author Admin
 */
public class AccessFilter extends GenericFilterBean {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        System.out.println(currentUserCanAccessPage(request));
        if (!currentUserCanAccessPage(request)) {
            throw new AccessDeniedException("");
        }
        chain.doFilter(request, response);
    }

    private boolean currentUserCanAccessPage(ServletRequest request) {
        String url = ((HttpServletRequest) request).getRequestURI();
        String servletPath = ((HttpServletRequest) request).getServletPath();
        if (servletPath != null && servletPath.startsWith("/resources")) {
            return true;
        } else {
//            role_anonymous 
            Authentication aut = SecurityContextHolder.getContext().getAuthentication();
            if (servletPath.startsWith("/login")) {
                return true;
            } else {
                if (aut instanceof AnonymousAuthenticationToken) {
                    AnonymousAuthenticationToken ano = (AnonymousAuthenticationToken) aut;
                    Object obj = ano.getPrincipal();
//                    anonymousUser
                } else if (aut instanceof UsernamePasswordAuthenticationToken) {
                    if (servletPath.equals("/")) {
                        return true;
                    }
                    UserCustomImpl user = (UserCustomImpl) SecurityContextHolder.getContext()
                            .getAuthentication().getPrincipal();
                    if (!user.getUsers().getIsAdmin().equals(1)) {
                        Set<Menu> menu = (Set<Menu>) ((HttpServletRequest) request).getSession().getAttribute("menu");
                        boolean flag = false;
                        for (Menu obj : menu) {
                            for (Menu objChild : obj.getListMenu()) {
                                  if(servletPath.contains("/"+objChild.getUrl())){
                                      flag = true;
                                  }
                            }
                        }
                        return flag;
                    } else {
                        return true;
                    }
                }
            }
            return true;
        }
    }

}
