/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.ImportDao;
import com.namph.entity.Import;
import com.namph.utils.Utils;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author namph
 */
@Transactional
public class ImportDaoImpl implements ImportDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Import> getListImport(Import imp) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Import.class);
        cri.add(Restrictions.ge("createdDate", Utils.stringDDMMYYY2Date(imp.getFromDate())));
        cri.add(Restrictions.le("createdDate", Utils.stringDDMMYYYHHMMSS2Date(imp.getToDate() + " 23:59:59")));
        cri.add(Restrictions.ne("no", 0));
        cri.addOrder(Order.desc("createdDate"));
        cri.setFirstResult((imp.getPageCurrent() - 1) * imp.getPageSize());
        cri.setMaxResults(imp.getPageSize());
        List<Import> lst = cri.list();
        return lst;
    }

    @Override
    public int getCount(Import imp) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Import.class);
        cri.add(Restrictions.ge("createdDate", Utils.stringDDMMYYY2Date(imp.getFromDate())));
        cri.add(Restrictions.le("createdDate", Utils.stringDDMMYYYHHMMSS2Date(imp.getToDate() + " 23:59:59")));
        cri.add(Restrictions.ne("no", 0));
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }

    @Override
    public int getMaxNoByMonth(Import imp) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Import.class);
        imp.setCreatedDate(null);
        cri.add(Restrictions.ge("createdDate", Utils.stringDDMMYYY2Date(imp.getStrCreateDate())));
        cri.setProjection(Projections.max("no"));
        Integer count = (Integer) cri.uniqueResult();
        return Integer.valueOf(count == null ? "0" : count.toString());
    }

    @Override
    public int insertImp(Import imp) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(imp);
        return imp.getId();
    }

    @Override
    public Import getImpById(Import imp) {
        Session session = this.sessionFactory.getCurrentSession();
        imp = (Import) session.get(Import.class, imp.getId());
        if (imp.getLstDetail() != null) {
            Hibernate.initialize(imp.getLstDetail());
        }
        return imp;
    }

    @Override
    public int deleteImp(Import imp) {
        Session session = this.sessionFactory.getCurrentSession();
        org.hibernate.Query query = session.createQuery("delete Import where id = :id ");
        query.setParameter("id", imp.getId());
        int result = query.executeUpdate();
        session.flush();
        return result;
    }

    @Override
    public int deleteImpDauKy(Date from, Date to) {
        Session session = this.sessionFactory.getCurrentSession();
        StringBuilder sb = new StringBuilder();
        sb.append("delete Import where no = 0 and date(createdDate) >= date(:fromDate) ");
        sb.append(" and date(createdDate) <= date(:toDate)");
        org.hibernate.Query query = session.createQuery(sb.toString());
        query.setParameter("fromDate", from);
        query.setParameter("toDate", to);
        int result = query.executeUpdate();
        session.flush();
        return result;
    }

}
