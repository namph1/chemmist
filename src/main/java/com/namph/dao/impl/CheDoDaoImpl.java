/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.ChedoDao;
import com.namph.entity.CheDo;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author namph
 */
@Transactional
public class CheDoDaoImpl implements ChedoDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<CheDo> getListChedo(CheDo chedo) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = setCri(session, chedo);
        if (chedo.getPageCurrent() > 0) {
            cri.setFirstResult((chedo.getPageCurrent() - 1) * chedo.getPageSize());
            cri.setMaxResults(chedo.getPageSize());
        }
        cri.addOrder(Order.asc("code"));
        List<CheDo> lst = cri.list();
        return lst;
    }

    @Override
    public int getCountChedo(CheDo chedo) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = setCri(session, chedo);
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }

    private Criteria setCri(Session session, CheDo chedo) {
        Criteria cri = session.createCriteria(CheDo.class);

        if (!chedo.getCode().trim().equals("")) {
            cri.add(Restrictions.like("code", chedo.getCode().trim(), MatchMode.ANYWHERE));
        }

        return cri;
    }

    @Override
    public int insertChedo(List<CheDo> lstObj) {
        Session session = this.sessionFactory.getCurrentSession();
        int i = 0;
        if (!lstObj.isEmpty()) {
            for (CheDo obj : lstObj) {
                session.persist(obj);
                i++;
            }
            session.flush();
        }
        return i;
    }

    @Override
    public int updateChedo(CheDo chedo) {
        Session session = this.sessionFactory.getCurrentSession();
        session.merge(chedo);
        session.flush();
        return chedo.getId();
    }

    @Override
    public int insertOneCheDo(CheDo chedo) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(chedo);
        session.flush();
        return chedo.getId();
    }

    @Override
    public CheDo getCheDo(int id) {
         Session session = this.sessionFactory.getCurrentSession();
         return (CheDo) session.get(CheDo.class, id);
    }
}
