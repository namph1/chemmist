/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.ExportDao;
import com.namph.entity.Export;
import com.namph.utils.Utils;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.sql.JoinType;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author namph
 */
@Transactional
public class ExportDaoImpl implements ExportDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public int getCount(Export exp) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Export.class, "exp");
        cri.createAlias("exp.customer", "customer", JoinType.LEFT_OUTER_JOIN);
        cri.add(Restrictions.ge("createdDate", Utils.stringDDMMYYY2Date(exp.getFromDate())));
        cri.add(Restrictions.le("createdDate", Utils.stringDDMMYYYHHMMSS2Date(exp.getToDate() + " 23:59:59")));
        if (!StringUtils.isEmpty(exp.getCustomerName())) {
            cri.add(Restrictions.like("customer.name", exp.getCustomerName().trim(), MatchMode.ANYWHERE));
        }
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }

    @Override
    public List<Export> getListByCondition(Export exp) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Export.class, "exp");
        cri.createAlias("exp.customer", "customer", JoinType.LEFT_OUTER_JOIN);
        cri.add(Restrictions.ge("createdDate", Utils.stringDDMMYYY2Date(exp.getFromDate())));
        cri.add(Restrictions.le("createdDate", Utils.stringDDMMYYYHHMMSS2Date(exp.getToDate() + " 23:59:59")));
        if (!StringUtils.isEmpty(exp.getCustomerName())) {
            cri.add(Restrictions.like("customer.name", exp.getCustomerName().trim(), MatchMode.ANYWHERE));
        }
        cri.addOrder(Order.desc("createdDate"));
        if (exp.getPageCurrent() > 0) {
            cri.setFirstResult((exp.getPageCurrent() - 1) * exp.getPageSize());
            cri.setMaxResults(exp.getPageSize());
        }
        List<Export> lst = cri.list();
        return lst;
    }

    @Override
    public int deleteExp(Export exp) {
        Session session = this.sessionFactory.getCurrentSession();
        org.hibernate.Query query = session.createQuery("delete Export where id = :id ");
        query.setParameter("id", exp.getId());
        int result = query.executeUpdate();
        session.flush();
        return result;
    }

    @Override
    public Export getExpById(Export exp) {
        Session session = this.sessionFactory.getCurrentSession();
        exp = (Export) session.get(Export.class, exp.getId());
        if (exp.getLstDetail() != null) {
            Hibernate.initialize(exp.getLstDetail());
        }
        return exp;
    }

    @Override
    public int getMaxNoByMonth(Export emp) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Export.class);
        emp.setCreatedDate(null);
        cri.add(Restrictions.ge("createdDate", Utils.stringDDMMYYY2Date(emp.getStrCreateDate())));
        cri.setProjection(Projections.max("no"));
        Integer count = (Integer) cri.uniqueResult();
        return Integer.valueOf(count == null ? "0" : count.toString());
    }

    @Override
    public int insertExp(Export emp) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.save(emp);
        return emp.getId();
    }

    @Override
    public int updateExp(Export emp) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(emp);
        return emp.getId();
    }

    @Override
    public int getCountFromTo(Export exp) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Export.class, "exp");
        cri.add(Restrictions.ge("createdDate", Utils.stringDDMMYYY2Date(exp.getFromDate())));
        cri.add(Restrictions.le("createdDate", Utils.stringDDMMYYYHHMMSS2Date(exp.getToDate())));
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }

}
