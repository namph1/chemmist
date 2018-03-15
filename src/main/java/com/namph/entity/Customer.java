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
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name = "tbl_customer")
public class Customer extends PagingModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "customer_seq")
    @SequenceGenerator(name="customer_seq", sequenceName = "tbl_customer_ID_seq", allocationSize=50)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "CODE")
    private String code;
    @Column(name = "NAME")
    private String name;
    @Column(name = "FACEBOOK")
    private String facebook;
    @Column(name = "ADDRESS")
    private String address;
    @Column(name = "PHONE")
    private String phone;
    @Column(name = "LEVEL")
    private Integer level;
    @Column(name = "TYPE")
    private Integer type;
    @Column(name = "STATUS")
    private Integer status;
    @Column(name = "CREATED_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
    private List<Export> lstExport = new ArrayList<Export>();

    @OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
    private List<Import> lstImport = new ArrayList<Import>();

    @Transient
    private String sStatus;

    public Customer(Integer id, Integer status) {
        this.id = id;
        this.status = status;
    }

    public Customer(Integer id) {
        this.id = id;
    }

    public Customer() {
    }

    public Customer(Integer id, String code, String name, Integer status) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.status = status;
    }

    public Customer(Integer id, String code, String name, Integer status, Integer type) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.type = type;
        this.status = status;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getsStatus() {
        if (status != null) {
            switch (status) {
                case 0:
                    sStatus = "Ngưng hoạt động";
                    break;
                case 1:
                    sStatus = "Đang hoạt động";
                    break;
            }
        }
        return sStatus;
    }

    public void setsStatus(String sStatus) {
        this.sStatus = sStatus;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public int getPageCurrent() {
        // TODO Auto-generated method stub
        return super.getPageCurrent();
    }

    @Override
    public void setPageCurrent(int pageCurrent) {
        // TODO Auto-generated method stub
        super.setPageCurrent(pageCurrent);
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 79 * hash + Objects.hashCode(this.id);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Customer other = (Customer) obj;
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        return true;
    }

    public List<Export> getLstExport() {
        return lstExport;
    }

    public void setLstExport(List<Export> lstExport) {
        this.lstExport = lstExport;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public List<Import> getLstImport() {
        return lstImport;
    }

    public void setLstImport(List<Import> lstImport) {
        this.lstImport = lstImport;
    }

}
