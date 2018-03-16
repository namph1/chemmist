/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.UserDao;
import com.namph.entity.MyUser;
import com.namph.entity.Roles;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

/**
 *
 * @author namph
 */
@Transactional
public class UserDaoImpl implements UserDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public MyUser findUserByUserName(String userName) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(MyUser.class);
        cri.add(Restrictions.eq("name", userName));
        cri.setMaxResults(1);
        MyUser user = (MyUser) cri.uniqueResult();
        Hibernate.initialize(user.getRoles());
        return user;
    }

    @Override
    public int getCount(MyUser user) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = setCrite(session, user);
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }

    @Override
    public List<MyUser> getListUser(MyUser user) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = setCrite(session, user);
        if (user.getPageCurrent() > 0) {
            cri.setFirstResult((user.getPageCurrent() - 1) * user.getPageSize());
            cri.setMaxResults(user.getPageSize());
        }
        cri.addOrder(Order.asc("name"));
        List<MyUser> lst = cri.list();
        return lst;
    }

    private Criteria setCrite(Session session, MyUser user) {
        Criteria cri = session.createCriteria(MyUser.class);
        return cri;
    }

    @Override
    public int addUser(MyUser user) {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(user);
        session.flush();
        return user.getUserId();
    }

    @Override
    public int editUser(MyUser user) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(user);
        return user.getUserId();
    }

    @Override
    public MyUser getUserById(MyUser user) {
        Session session = this.sessionFactory.getCurrentSession();
        return (MyUser) session.get(MyUser.class, user.getUserId());
    }

    @Override
    public List<Roles> getAllRoles(MyUser user) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Roles.class);
        List<Integer> lstRoleId = new ArrayList<Integer>();
        MyUser users = getUserById(user);
        Hibernate.initialize(users.getRoles());
        if (!users.getRoles().isEmpty()) {
            for (Roles role : users.getRoles()) {
                lstRoleId.add(role.getRoleId());
            }
            cri.add(Restrictions.not(Restrictions.in("roleId", lstRoleId)));
        }
        return cri.list();
    }

    @Override
    public Set<Roles> getRolesUser(MyUser users) {
        MyUser user = getUserById(users);
        Hibernate.initialize(user.getRoles());
        return user.getRoles();
    }

    @Override
    public void assignRole(MyUser users) {
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createSQLQuery(" delete from tbl_user_role where \"USER_ID\" = :userId ").setParameter("userId", users.getUserId());
        query.executeUpdate();
        if (!StringUtils.isEmpty(users.getStrRoleId())) {
            String[] arr = users.getStrRoleId().split(",");
            if (arr.length > 0) {
                for (String strCus : arr) {
                    query = session.createSQLQuery("insert into tbl_user_role(\"USER_ID\", \"ROLE_ID\") VALUES(:userId,:roleId)")
                            .setParameter("userId", users.getUserId())
                            .setParameter("roleId", Integer.parseInt(strCus));
                    query.executeUpdate();
                }
            }
        }
        session.flush();
    }

}
