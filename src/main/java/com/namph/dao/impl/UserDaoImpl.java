/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.UserDao;
import com.namph.entity.MyUser;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;

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

}
