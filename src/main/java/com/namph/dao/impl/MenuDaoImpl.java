/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.MenuDao;
import com.namph.entity.Menu;
import com.namph.entity.MenuAction;
import com.namph.entity.Roles;
import java.util.List;
import java.util.Set;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author namph
 */
@Transactional
public class MenuDaoImpl implements MenuDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Menu> getAllMenu() {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Menu.class);
        cri.add(Restrictions.eq("isParent", 1));
        cri.addOrder(Order.asc("orders"));
        List<Menu> lst = cri.list();
        if (!lst.isEmpty()) {
            for (Menu objMenu : lst) {
                Hibernate.initialize(objMenu.getListMenu());
            }
        }
        return lst;
    }

    @Override
    public Set<Menu> getListMenuByRole(Integer roleId) {
        Session session = this.sessionFactory.getCurrentSession();
        Roles role = (Roles) session.get(Roles.class, roleId);
        Hibernate.initialize(role.getMenus());
        if (!role.getMenus().isEmpty()) {
            for (Menu objMenu : role.getMenus()) {
                Hibernate.initialize(objMenu.getListMenu());
            }
        }
        return role.getMenus();
    }

    @Override
    public List<MenuAction> getallActionMenu() {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(MenuAction.class);
        List<MenuAction> lst = cri.list();
        return lst;
    }

}
