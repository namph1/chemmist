/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.CustomerDao;
import com.namph.entity.Customer;
import com.namph.utils.Utils;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
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
public class CustomerDaoImpl implements CustomerDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Customer> getListCustomer(Customer customer) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Customer.class);
        if (null != customer.getStatus() && !customer.getStatus().equals(-1)) {
            cri.add(Restrictions.eq("status", customer.getStatus()));
        }
        if (!org.springframework.util.StringUtils.isEmpty(customer.getCode())) {
            if (customer.getCode().matches("(\\D*)(\\d+)")) {
                cri.add(Restrictions.like("code", customer.getCode().replaceAll("\\d+", "").trim(), MatchMode.END));
                cri.add(Restrictions.eq("level", Integer.valueOf(customer.getCode().replaceAll("\\D+", "").trim())));
            } else {
                cri.add(Restrictions.like("code", customer.getCode().trim(), MatchMode.ANYWHERE));
            }
        }
        if (!org.springframework.util.StringUtils.isEmpty(customer.getName())) {
            cri.add(Restrictions.like("name", customer.getName().trim(), MatchMode.ANYWHERE));
        }
        if (!org.springframework.util.StringUtils.isEmpty(customer.getPhone())) {
            cri.add(Restrictions.like("phone", customer.getPhone().trim(), MatchMode.ANYWHERE));
        }
        if (customer.getType() != null) {
            cri.add(Restrictions.eq("type", customer.getType()));
        }

        if (customer.getPageCurrent() > 0) {
            cri.setFirstResult((customer.getPageCurrent() - 1) * customer.getPageSize());
            cri.setMaxResults(customer.getPageSize());
        }
        cri.addOrder(Order.asc("code"));
        cri.addOrder(Order.asc("level"));
        List<Customer> lst = cri.list();
        return lst;
    }

    @Override
    public int edit(Customer customer) throws Exception{
        Session session = this.sessionFactory.getCurrentSession();
        if (customer.getId() != null) {
            if (customer.getStatus() != null) {
                customer = (Customer) session.get(Customer.class, customer.getId());
                switch (customer.getStatus()) {
                    case 0:
                        customer.setStatus(1);
                        break;
                    case 1:
                        customer.setStatus(0);
                        break;
                }
                session.merge(customer);
            } else {
                Customer cus = getCustomerById(customer.getId(), true);
                if (!cus.getCode().equals(customer.getCode())) {
                    Criteria cri = session.createCriteria(Customer.class);
                    cri.add(Restrictions.eq("code", customer.getCode()));
                    cri.addOrder(Order.desc("level"));
                    List<Customer> lst = cri.list();
                    if (lst.isEmpty()) {
                        customer.setLevel(1);
                        customer.setType(1);
                    } else {
                        customer.setLevel(lst.get(0).getLevel() + 1);
                    }
                }

                customer.setStatus(1);
                session.merge(customer);
            }
        } else {
            Criteria cri = session.createCriteria(Customer.class);
            cri.add(Restrictions.eq("code", customer.getCode()));
            cri.addOrder(Order.desc("level"));
            List<Customer> lst = cri.list();
            if (lst.isEmpty()) {
                customer.setLevel(1);
                 customer.setType(1);
            } else {
                customer.setLevel(lst.get(0).getLevel() + 1);
            }

            customer.setStatus(1);
            customer.setCreatedDate(Utils.getTimeVN());
            session.persist(customer);
        }
        return customer.getId();
    }

    @Override
    public Customer getCustomerById(Integer customerid, boolean isLazy) {
        Session session = this.sessionFactory.getCurrentSession();
        Customer customer = (Customer) session.get(Customer.class, customerid);
        return customer;
    }

    @Override
    public int getCount(Customer customer) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Customer.class);
        if (null != customer.getStatus() && !customer.getStatus().equals(-1)) {
            cri.add(Restrictions.eq("status", customer.getStatus()));
        }
        if (!StringUtils.isEmpty(customer.getCode())) {
            if (customer.getCode().matches("(\\D*)(\\d+)")) {
                cri.add(Restrictions.like("code", customer.getCode().replaceAll("\\d+", "").trim(), MatchMode.END));
                cri.add(Restrictions.eq("level", Integer.valueOf(customer.getCode().replaceAll("\\D+", "").trim())));
            } else {
                cri.add(Restrictions.like("code", customer.getCode().trim(), MatchMode.ANYWHERE));
            }
        }
        if (!StringUtils.isEmpty(customer.getName())) {
            cri.add(Restrictions.like("name", customer.getName().trim(), MatchMode.ANYWHERE));
        }
        if (!StringUtils.isEmpty(customer.getPhone())) {
            cri.add(Restrictions.like("phone", customer.getPhone().trim(), MatchMode.ANYWHERE));
        }
        if (customer.getType() != null) {
            cri.add(Restrictions.eq("type", customer.getType()));
        }
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }

}
