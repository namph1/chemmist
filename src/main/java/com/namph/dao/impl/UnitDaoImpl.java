/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.UnitDao;
import com.namph.entity.Unit;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

/**
 *
 * @author namph
 */
@Transactional
public class UnitDaoImpl implements UnitDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Unit> getListUnit(Unit unit) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Unit.class);
        if (unit.getId() != null && !unit.getId().equals(-1)) {
            cri.add(Restrictions.eq("id", unit.getId()));
        }

        if (!StringUtils.isEmpty(unit.getName())) {
            cri.add(Restrictions.like("name", unit.getName().trim(), MatchMode.ANYWHERE));
        }
        if (unit.getPageCurrent() > 0) {
            cri.setFirstResult((unit.getPageCurrent() - 1) * unit.getPageSize());
            cri.setMaxResults(unit.getPageSize());
        }
        List<Unit> lst = cri.list();
        return lst;
    }

    @Override
    public int getCount(Unit unit) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Unit.class);
        if (unit.getId() != null && !unit.getId().equals(-1)) {
            cri.add(Restrictions.eq("id", unit.getId()));
        }
        if (!StringUtils.isEmpty(unit.getName())) {
            cri.add(Restrictions.like("name", unit.getName().trim(), MatchMode.ANYWHERE));
        }
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }

    @Override
    public int edit(Unit unit) {
        Session session = this.sessionFactory.getCurrentSession();
        session.merge(unit);
        return unit.getId();
    }

    @Override
    public int add(Unit unit) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(unit);
        return unit.getId();
    }

}
