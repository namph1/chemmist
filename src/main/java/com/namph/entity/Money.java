/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.entity;

import com.namph.model.PagingModel;
import com.namph.utils.Utils;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "tbl_money")
public class Money extends PagingModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "money_seq")
    @SequenceGenerator(name = "money_seq", sequenceName = "tbl_money_ID_seq", allocationSize = 50)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "TYPE", nullable = false, length = 1)
    private Integer type;
    @Column(name = "TOTAL", nullable = false)
    private Float total;
    @Column(name = "NOTE")
    private String note;
    @Column(name = "CREATED_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;
    @Column(name = "STATUS", nullable = false, length = 1)
    private Integer status;
    @ManyToOne
    @JoinColumn(name = "\"CUSTOMER_ID\"", nullable = true)
    private Customer customer;
    @Column(name = "NO")
    private Integer no;

    @Transient
    private String sStatus, strCreateDate, fromDate, toDate, code, strNo;
    @Transient
    private Integer customerId, bankId, employeeId;

    public Money(Integer id, Integer type, Integer status) {
        this.id = id;
        this.type = type;
        this.status = status;
    }

    public Money() {
    }

    public Money(Integer type, Integer status) {
        this.type = type;
        this.status = status;
    }

    public Integer getNo() {
        return no;
    }

    public void setNo(Integer no) {
        this.no = no;
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

    public Integer getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Integer employeeId) {
        this.employeeId = employeeId;
    }

    public Integer getBankId() {
        return bankId;
    }

    public void setBankId(Integer bankId) {
        this.bankId = bankId;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public String getsStatus() {
        if (status != null) {
            switch (status) {
                case 0:
                    sStatus = "Thu";
                    break;
                case 1:
                    sStatus = "Chi";
                    break;
            }
        }
        return sStatus;
    }

    public void setsStatus(String sStatus) {
        this.sStatus = sStatus;
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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Float getTotal() {
        return total;
    }

    public void setTotal(Float total) {
        this.total = total;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
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
