/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.entity;

import com.namph.model.PagingModel;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author namph
 */
@Entity
@Table(name = "tbl_product_type")
public class GroupProduct extends PagingModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "product_type_seq")
    @SequenceGenerator(name="product_type_seq", sequenceName = "tbl_product_type_ID_seq", allocationSize=50)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "NAME", nullable = false)
    private String name;
    @Column(name = "NOTE", nullable = false)
    private String note;
    @Column(name = "USER_ID", nullable = false)
    private Integer userId;
    @Column(name = "STATUS")
    private Integer status;
    @Column(name = "CREATED_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;
    @OneToMany(mappedBy = "group")
    private List<Product> lstProduct = new ArrayList<Product>();

    public GroupProduct(Integer id) {
        this.id = id;
    }

    public GroupProduct() {
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public List<Product> getLstProduct() {
        return lstProduct;
    }

    public void setLstProduct(List<Product> lstProduct) {
        this.lstProduct = lstProduct;
    }

    @Override
    public void setPageCurrent(int pageCurrent) {
        super.setPageCurrent(pageCurrent); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int getPageCurrent() {
        return super.getPageCurrent(); //To change body of generated methods, choose Tools | Templates.
    }

}
