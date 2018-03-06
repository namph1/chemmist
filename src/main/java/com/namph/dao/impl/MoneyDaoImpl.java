/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.MoneyDao;
import com.namph.entity.Money;
import com.namph.utils.Utils;
import java.util.Date;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.sql.JoinType;
import org.hibernate.transform.Transformers;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author namph
 */
@Transactional
public class MoneyDaoImpl implements MoneyDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public int getCount(Money money) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = setCriteria(session, money);
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }

    @Override
    public List<Money> getListMoney(Money money) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = setCriteria(session, money);

        cri.addOrder(Order.desc("createdDate"));

        if (money.getPageCurrent() > 0) {
            cri.setFirstResult((money.getPageCurrent() - 1) * money.getPageSize());
            cri.setMaxResults(money.getPageSize());
        }
        List<Money> lst = cri.list();
        return lst;
    }

    @Override
    public int insertMoney(Money money) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(money);
        return money.getId();
    }

    @Override
    public int edittMoney(Money money) {
        Session session = this.sessionFactory.getCurrentSession();
        session.merge(money);
        return money.getId();
    }

    @Override
    public int deleteMoney(Money money) {
        Session session = this.sessionFactory.getCurrentSession();
        money = (Money) session.get(Money.class, money.getId());
        session.delete(money);
        return 1;
    }

    @Override
    public Double getTotal(Money money) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = setCriteria(session, money);
        cri.setProjection(Projections.sum("total"));
        Double total = (Double) cri.uniqueResult();
        return total;
    }

    @Override
    public Money getMoneyById(Money money) {
        Session session = this.sessionFactory.getCurrentSession();
        return (Money) session.get(Money.class, money.getId());
    }

    private Criteria setCriteria(Session session, Money money) {
        Criteria cri = session.createCriteria(Money.class, "money");
        cri.createAlias("money.customer", "customer", JoinType.LEFT_OUTER_JOIN);
//        cri.createAlias("money.employee", "employee", JoinType.LEFT_OUTER_JOIN);
        cri.add(Restrictions.eq("type", money.getType()));
        cri.add(Restrictions.ge("createdDate", Utils.stringDDMMYYY2Date(money.getFromDate())));
        cri.add(Restrictions.le("createdDate", Utils.stringDDMMYYYHHMMSS2Date(money.getToDate() + " 23:59:59")));
        cri.add(Restrictions.ne("no", 0));
        if (money.getStatus() != null && money.getStatus() != -1) {
            cri.add(Restrictions.eq("status", money.getStatus()));
        }
//        if (!StringUtils.isEmpty(money.getCode())) {
//            Criterion cri1 = Restrictions.and(Restrictions.like("customer.code", money.getCode().replaceAll("\\d+", "").trim(), MatchMode.ANYWHERE));
//            if (money.getCode().matches("(\\D*)(\\d+)")) {
//                cri1 = Restrictions.and(Restrictions.like("customer.code", money.getCode().replaceAll("\\d+", "").trim(), MatchMode.ANYWHERE),
//                        Restrictions.eq("customer.level", Integer.valueOf(money.getCode().replaceAll("\\D+", "").trim())));
//            }
////            Criterion cri2 = Restrictions.and(Restrictions.like("employee.code", money.getCode().replaceAll("\\d+", "").trim(), MatchMode.ANYWHERE));
////            if (money.getCode().matches("(\\D*)(\\d+)")) {
////                cri2 = Restrictions.and(Restrictions.like("employee.code", money.getCode().replaceAll("\\d+", "").trim(), MatchMode.ANYWHERE),
////                        Restrictions.eq("employee.orders", Integer.valueOf(money.getCode().replaceAll("\\D+", "").trim())));
////            }
//            cri.add(Restrictions.or(cri1, cri2));
//        }
        return cri;
    }

    @Override
    public int getMaxNoOfCurMonthByTypeByStatus(Money money) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Money.class);
        cri.add(Restrictions.ge("createdDate", Utils.getFirstDayOfCurrentMonth(true)));
        cri.add(Restrictions.eq("type", money.getType()));
        cri.add(Restrictions.eq("status", money.getStatus()));
        cri.setProjection(Projections.max("no"));
        Integer count = (Integer) cri.uniqueResult();
        return Integer.valueOf(count == null ? "0" : count.toString());
    }

    @Override
    public int deleteDauKy(Date from, Date to) {
        Session session = this.sessionFactory.getCurrentSession();
        StringBuilder sb = new StringBuilder();
        sb.append("delete Money where no = 0 and type = 0 and date(createdDate) >= date(:fromDate) ");
        sb.append(" and date(createdDate) <= date(:toDate)");
        org.hibernate.Query query = session.createQuery(sb.toString());
        query.setParameter("fromDate", from);
        query.setParameter("toDate", to);
        int result = query.executeUpdate();
        session.flush();
        return result;
    }

    @Override
    public int getMoneyTonDau(Date from) throws Exception {
        Session session = this.sessionFactory.getCurrentSession();
        try {

            StringBuilder sb = new StringBuilder();
            sb.append("select IF(sq.ton_dau IS NULL, 0, sq.TON_DAU)+ IF(sq.thu IS NULL, 0, sq.thu) - IF(sq.chi IS NULL, 0, sq.chi) as tondau  ");
            sb.append(" from tbl_soquy sq where no = 1 and DATE(sq.INSERT_DATE) = DATE(:from) -1 ; ");
            org.hibernate.Query query = session.createSQLQuery(sb.toString());
            query.setParameter("from", from);
            Double reuslt = (Double) query.uniqueResult();
            return reuslt == null ? 0 : reuslt.intValue();
        } catch (Exception e) {
            throw e;
        }
    }
}
