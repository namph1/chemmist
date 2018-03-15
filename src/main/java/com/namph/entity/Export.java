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
@Table(name = "tbl_export")
public class Export extends PagingModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "export_seq")
    @SequenceGenerator(name="export_seq", sequenceName = "tbl_export_ID_seq", allocationSize=50)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "NO")
    private Integer no;
    @Column(name = "CREATED_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate = new Date();
    @Column(name = "TOTAL")
    private Float total;
    @Column(name = "WEIGHT")
    private Float weight;
    @Column(name = "DISCOUNT")
    private Float discount;
    @Column(name = "TOTAL_LAST")
    private Float totalLast;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "\"CUSTOMER_ID\"", nullable = false)
    private Customer customer;

    @OneToMany(mappedBy = "exp", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<ExportDetail> lstDetail = new ArrayList<ExportDetail>();

    @ManyToOne
    @JoinColumn(name = "\"USER_ID\"", nullable = true)
    private MyUser users;

    @Transient
    private String fromDate, toDate, strCreateDate, strNo, customerName;

    public Export(Integer id) {
        this.id = id;
    }

    public Export() {
    }

    public MyUser getUsers() {
        return users;
    }

    public void setUsers(MyUser users) {
        this.users = users;
    }

    public Float getWeight() {
        return weight;
    }

    public void setWeight(Float weight) {
        this.weight = weight;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
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

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Float getTotal() {
        return total;
    }

    public void setTotal(Float total) {
        this.total = total;
    }

    public Float getDiscount() {
        return discount;
    }

    public void setDiscount(Float discount) {
        this.discount = discount;
    }

    public Float getTotalLast() {
        return totalLast;
    }

    public void setTotalLast(Float totalLast) {
        this.totalLast = totalLast;
    }


    public String getStrNo() {
        if (no < 10) {
            strNo = "000" + no;
        } else if (no < 100) {
            strNo = "00" + no;
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

    @Override
    public void setPageCurrent(int pageCurrent) {
        super.setPageCurrent(pageCurrent); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int getPageCurrent() {
        return super.getPageCurrent(); //To change body of generated methods, choose Tools | Templates.
    }

    public List<ExportDetail> getLstDetail() {
        return lstDetail;
    }

    public void setLstDetail(List<ExportDetail> lstDetail) {
        this.lstDetail = lstDetail;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    
}
