/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.RoleDao;
import com.namph.entity.Roles;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author namph
 */
@Transactional
public class RoleDaoImpl implements RoleDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Roles> getListRoles(Roles role) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = setCriteria(session, role);
        if (role.getPageCurrent() > 0) {
            cri.setFirstResult((role.getPageCurrent() - 1) * role.getPageSize());
            cri.setMaxResults(role.getPageSize());
        }
        List<Roles> lst = cri.list();
        return lst;
    }

    @Override
    public int getCount(Roles role) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = setCriteria(session, role);
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }

    private Criteria setCriteria(Session session, Roles role) {
        Criteria cri = session.createCriteria(Roles.class);
        return cri;
    }

    @Override
    public Roles getRoleById(Roles role) {
        Session session = this.sessionFactory.getCurrentSession();
        Roles roles = (Roles) session.get(Roles.class, role.getRoleId());
        Hibernate.initialize(roles.getMenusAction());
        return roles;
    }

    @Override
    public int insertRole(Roles role) {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(role);
        session.flush();
        return role.getRoleId();
    }

    @Override
    public int updateRole(Roles role) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(role);
        session.flush();
        return role.getRoleId();
    }

    @Override
    public void assignMenu(Roles role) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createSQLQuery(" delete from tbl_role_menu where \"role_id\" = :roleId ")
                .setParameter("roleId", role.getRoleId());
        query.executeUpdate();
        
        query = session.createSQLQuery(" delete from tbl_role_menu_action where \"role_id\" = :roleId ")
                .setParameter("roleId", role.getRoleId());
        query.executeUpdate();
        
        Set<Integer> setMenuId = new HashSet<>();
        Set<Integer> setMenuActionId = new HashSet<>();
        for (String strMenu : role.getLstIdsMenu()) {
            if (strMenu.matches("\\d+\\-\\d+")) {
                setMenuId.add(Integer.valueOf(strMenu.split("-")[0]));
                setMenuId.add(Integer.valueOf(strMenu.split("-")[1]));
            } else if (strMenu.matches("\\d+\\-\\-\\d+\\-\\-\\d+")) {
                setMenuId.add(Integer.valueOf(strMenu.split("--")[0]));
                setMenuId.add(Integer.valueOf(strMenu.split("--")[1]));
                setMenuActionId.add(Integer.valueOf(strMenu.split("--")[2]));
            }else{
                setMenuId.add(Integer.valueOf(strMenu));
            }
        }

        for (Integer menuId : setMenuId) {
            query = session.createSQLQuery("insert into tbl_role_menu(\"menu_id\", \"role_id\") VALUES(:menuId,:roleId)")
                    .setParameter("menuId", menuId)
                    .setParameter("roleId", role.getRoleId());
            query.executeUpdate();
        }
         for (Integer menuActId : setMenuActionId) {
            query = session.createSQLQuery("insert into tbl_role_menu_action(\"menu_action_id\", \"role_id\") VALUES(:menuActId,:roleId)")
                    .setParameter("menuActId", menuActId)
                    .setParameter("roleId", role.getRoleId());
            query.executeUpdate();
        }
        session.flush();
    }
}
