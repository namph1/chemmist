/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.service;

import com.namph.dao.MenuDao;
import com.namph.dao.RoleDao;
import com.namph.entity.Menu;
import com.namph.entity.MenuAction;
import com.namph.entity.Roles;
import com.namph.model.UserCustomImpl;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

/**
 *
 * @author namph
 */
public class MySimpleUrlAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    protected Log logger = LogFactory.getLog(this.getClass());
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    private MenuDao menuDao;
    private RoleDao roleDao;

    public RoleDao getRoleDao() {
        return roleDao;
    }

    public void setRoleDao(RoleDao roleDao) {
        this.roleDao = roleDao;
    }

    public MenuDao getMenuDao() {
        return menuDao;
    }

    public void setMenuDao(MenuDao menuDao) {
        this.menuDao = menuDao;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response, Authentication authentication)
            throws IOException, ServletException {
        handle(request, response, authentication);
        clearAuthenticationAttributes(request);
    }

    protected void handle(HttpServletRequest request,
            HttpServletResponse response, Authentication authentication)
            throws IOException {

        UserCustomImpl user = (UserCustomImpl) authentication.getPrincipal();
        String targetUrl = determineTargetUrl(authentication, user);
        request.getSession().setAttribute("fullName", user.getUsers().getFullName());
        request.getSession().setAttribute("userName", user.getUsers().getName());
        request.getSession().setAttribute("createDate", user.getUsers().getStrCreateDate());
        request.getSession().setAttribute("positon", user.getUsers().getPosition());
        Set<Menu> setMenu = new HashSet<>();
        List<MenuAction> lstMenuAction = new ArrayList<>();
        if (user.getUsers().getIsAdmin() == 1) {
            setMenu = new HashSet<>(menuDao.getAllMenu());
            lstMenuAction.addAll(menuDao.getallActionMenu());
        } else {
            if (!user.getRoles().isEmpty()) {
                for (Roles role : user.getRoles()) {
                    setMenu.addAll(menuDao.getListMenuByRole(role.getRoleId()));
                    lstMenuAction.addAll(roleDao.getRoleById(role).getMenusAction());
                }
            }
            List<Menu> lstMenuChild = new ArrayList<>();
            List<Menu> lstMenuParent = new ArrayList<>();
            for (Menu menu : setMenu) {
                menu.getListMenu().clear();
                if (menu.getIsParent() != null && menu.getIsParent() == 1) {
                    lstMenuParent.add(menu);
                }
            }

            for (Menu menu : setMenu) {
                if (menu.getIsParent() != null && menu.getIsParent() == 0) {
                    lstMenuChild.add(menu);
                }
            }

            setMenu.clear();
            for (Menu menu1 : lstMenuParent) {
                for (Menu menu2 : lstMenuChild) {
                    if (menu2.getMenu().getId().equals(menu1.getId())) {
                        menu1.getListMenu().add(menu2);
                    }
                }
                setMenu.add(menu1);
            }
        }
        request.getSession().setAttribute("actionmenu", lstMenuAction);
        request.getSession().setAttribute("menu", Menu.sortByOrders(setMenu));
        if (response.isCommitted()) {
            logger.debug(
                    "Response has already been committed. Unable to redirect to "
                    + targetUrl);
            return;
        }

        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    protected String determineTargetUrl(Authentication authentication, UserCustomImpl user) {
        boolean isUser = false;
        boolean isAdmin = false;
        if (user.getUsers().getIsAdmin() != null && user.getUsers().getIsAdmin() == 1) {
            isAdmin = true;
        } else {
            Collection<? extends GrantedAuthority> authorities
                    = authentication.getAuthorities();
            for (GrantedAuthority grantedAuthority : authorities) {
                if (grantedAuthority.getAuthority().equals("ROLE_USER")) {
                    isUser = true;
                    break;
                } else if (grantedAuthority.getAuthority().equals("ROLE_ADMIN")) {
                    isAdmin = true;
                    break;
                } else {
                    isUser = true;
                    break;
                }
            }
        }
        if (isUser) {
            return "/";
        } else if (isAdmin) {
            return "/";
        } else {
            throw new IllegalStateException();
        }
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }

    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }

    protected RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }

}
