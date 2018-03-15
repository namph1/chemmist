/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.entity;

import com.namph.model.PagingModel;
import com.namph.utils.Utils;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 *
 * @author namph
 */
@Entity
@Table(name = "tbl_import")
public class Import extends PagingModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "import_seq")
    @SequenceGenerator(name = "import_seq", sequenceName = "tbl_import_ID_seq", allocationSize = 50)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "NO")
    private Integer no;
    @Column(name = "WEIGHT")
    private Float weight;
    @Column(name = "CREATED_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate = new Date();
    @OneToMany(mappedBy = "imp", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<ImportDetail> lstDetail = new ArrayList<ImportDetail>();
    @Column(name = "TOTAL_PRICE")
    private Float totalPrice;
    @Column(name = "FEE_SHIP")
    private Float feeShip;
    @Column(name = "RATE")
    private Float rate;
    @Column(name = "TOTAL")
    private Float total;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "\"CUSTOMER_ID\"", nullable = false)
    private Customer customer;

    @ManyToOne
    @JoinColumn(name = "\"USER_ID\"", nullable = true)
    private MyUser users;

    @Transient
    private String fromDate, toDate, strCreateDate, strNo;
    @Transient
    private Integer customerId;

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Float getFeeShip() {
        return feeShip;
    }

    public void setFeeShip(Float feeShip) {
        this.feeShip = feeShip;
    }

    public Float getRate() {
        return rate;
    }

    public void setRate(Float rate) {
        this.rate = rate;
    }

    public Float getTotal() {
        return total;
    }

    public void setTotal(Float total) {
        this.total = total;
    }

    public Float getWeight() {
        return weight;
    }

    public void setWeight(Float weight) {
        this.weight = weight;
    }

    public String getStrNo() {
        if (no < 10) {
            strNo = "000" + no;
        } else if (no < 100) {
            strNo = "00" + no;
        } else if (no < 1000) {
            strNo = "0" + no;
        }
        return strNo;
    }

    public void setStrNo(String strNo) {
        this.strNo = strNo;
    }

    public String getStrCreateDate() {
        if (createdDate != null) {
            strCreateDate = Utils.Date2DDMMYYYYH24MI(createdDate);
        }

        return strCreateDate;
    }

    public void setStrCreateDate(String strCreateDate) {
        this.strCreateDate = strCreateDate;
    }

    public String getFromDate() {
        return fromDate;
    }

    public void setFromDate(String fromDate) {
        this.fromDate = fromDate;
    }

    public String getToDate() {
        return toDate;
    }

    public void setToDate(String toDate) {
        this.toDate = toDate;
    }

    public List<ImportDetail> getLstDetail() {
        return lstDetail;
    }

    public void setLstDetail(List<ImportDetail> lstDetail) {
        this.lstDetail = lstDetail;
    }

    @Override
    public void setPageCurrent(int pageCurrent) {
        super.setPageCurrent(pageCurrent); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int getPageCurrent() {
        return super.getPageCurrent(); //To change body of generated methods, choose Tools | Templates.
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
    }

//    public Integer getUserId() {
//        return userId;
//    }
//
//    public void setUserId(Integer userId) {
//        this.userId = userId;
//    }
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public MyUser getUsers() {
        return users;
    }

    public void setUsers(MyUser users) {
        this.users = users;
    }

}
