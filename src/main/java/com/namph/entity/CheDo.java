/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.entity;

import com.namph.model.PagingModel;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Table(name = "vina_chedo")
public class CheDo extends PagingModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "vina_chedo_seq")
    @SequenceGenerator(name = "vina_chedo_seq", sequenceName = "vina_chedo_seq", allocationSize = 50)
    @Column(name = "id")
    private Integer id;
    @Column(name = "code")
    private String code;
    @Column(name = "name")
    private String name;
    @Column(name = "money")
    private Integer money;
    @Column(name = "content")
    private String content;
    @Column(name = "status")
    private Integer status;
    @Column(name = "insert_date")
    @Temporal(TemporalType.DATE)
    private Date insertDate;
    @Column(name = "update_date")
    @Temporal(TemporalType.DATE)
    private Date updateDate;

    
    @Transient
    private String sStatus;
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
    
    public String getsStatus() {
        if (status != null) {
            switch (status) {
                case 0:
                    sStatus = "Không sử dụng";
                    break;
                case 1:
                    sStatus = "Sử dụng";
                    break;
            }
        }
        return sStatus;
    }

    public void setsStatus(String sStatus) {
        this.sStatus = sStatus;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getMoney() {
        return money;
    }

    public void setMoney(Integer money) {
        this.money = money;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getInsertDate() {
        return insertDate;
    }

    public void setInsertDate(Date insertDate) {
        this.insertDate = insertDate;
    }

    public Date getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
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
