/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.ProductDao;
import com.namph.entity.Product;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author namph
 */
@Transactional
public class ProductDaoImpl implements ProductDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<Product> getListProduct(Product product) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Product.class);
        if (product.getId() != null && !product.getId().equals(-1)) {
            cri.add(Restrictions.eq("id", product.getId()));
        }
        if (product.getCode() != null && !product.getCode().trim().equals("")) {
            cri.add(Restrictions.like("code", product.getCode(), MatchMode.ANYWHERE).ignoreCase());
        }
        if (product.getName()!= null && !product.getName().trim().equals("")) {
            cri.add(Restrictions.like("name", product.getName(), MatchMode.ANYWHERE).ignoreCase());
        }
        if (product.getStatus() != null) {
            cri.add(Restrictions.eq("status", product.getStatus()));
        }
        if (product.getPageCurrent() > 0) {
            cri.setFirstResult((product.getPageCurrent() - 1) * product.getPageSize());
            cri.setMaxResults(product.getPageSize());
        }
        List<Product> lst = cri.list();
        return lst;
    }

    @Override
    public int addProduct(Product product) {
        Session session = this.sessionFactory.getCurrentSession();
        if (product.getId() != null) {
            session.merge(product);
        } else {
            session.persist(product);
        }
        return product.getId();
    }

    @Override
    public Product getProductByid(Integer id) {
        Session session = this.sessionFactory.getCurrentSession();
        Product product = (Product) session.get(Product.class, id);
//        Hibernate.initialize(product.getLstProduct());
        return product;
    }

    @Override
    public int editProduct(Product product) {
        Session session = this.sessionFactory.getCurrentSession();
        if (product.getStatus() != null) {
            product = (Product) session.get(Product.class, product.getId());
            switch (product.getStatus()) {
                case 0:
                    product.setStatus(1);
                    break;
                case 1:
                    product.setStatus(0);
                    break;
            }
            session.merge(product);
        } else {
            product.setStatus(1);
            session.merge(product);
        }
        return product.getId();
    }

    @Override
    public int getCount(Product product) {
        Session session = this.sessionFactory.getCurrentSession();
        Criteria cri = session.createCriteria(Product.class);
        if (product.getId() != null && !product.getId().equals(-1)) {
            cri.add(Restrictions.eq("id", product.getId()));
        }
        if (product.getCode() != null && !product.getCode().trim().equals("")) {
            cri.add(Restrictions.like("code", product.getCode(), MatchMode.ANYWHERE).ignoreCase());
        }
        if (product.getName()!= null && !product.getName().trim().equals("")) {
            cri.add(Restrictions.like("name", product.getName(), MatchMode.ANYWHERE).ignoreCase());
        }
        if (product.getStatus() != null) {
            cri.add(Restrictions.eq("status", product.getStatus()));
        }
        cri.setProjection(Projections.rowCount());
        Long count = (Long) cri.uniqueResult();
        return Integer.valueOf(count.toString());
    }
}
