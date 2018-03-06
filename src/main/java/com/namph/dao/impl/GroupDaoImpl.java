/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.GroupDao;
import com.namph.entity.GroupProduct;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

/**
 *
 * @author namph
 */
@Transactional
public class GroupDaoImpl implements GroupDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<GroupProduct> getListProduct(GroupProduct group) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(GroupProduct.class);
        if (group.getId() != null && !group.getId().equals(-1)) {
            cri.add(Restrictions.eq("id", group.getId()));
        }
        if (!StringUtils.isEmpty(group.getName())) {
            cri.add(Restrictions.eq("name", group.getName()));
        }
        cri.add(Restrictions.eq("status", 1));
        if (group.getPageCurrent() > 1) {
            cri.setFirstResult((group.getPageCurrent() - 1) * group.getPageSize());
            cri.setMaxResults(group.getPageSize());
        }
        List<GroupProduct> lst = cri.list();
        return lst;
    }

    @Override
    public int edit(GroupProduct group) {
        Session session = this.sessionFactory.getCurrentSession();
        session.merge(group);
        return group.getId();
    }

    @Override
    public int add(GroupProduct group) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(group);
        return group.getId();
    }

    @Override
    public int getCount(GroupProduct group) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(GroupProduct.class);
        if (group.getId() != null && !group.getId().equals(-1)) {
            cri.add(Restrictions.eq("id", group.getId()));
        }
        if (!StringUtils.isEmpty(group.getName())) {
            cri.add(Restrictions.eq("name", group.getName()));
        }
        cri.add(Restrictions.eq("status", 1));
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }

    @Override
    public GroupProduct getGroup(GroupProduct group) {
        Session session = this.sessionFactory.getCurrentSession();
        group = (GroupProduct) session.get(GroupProduct.class, group.getId());
        return group;
    }
}
