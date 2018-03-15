/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.entity;

import com.namph.model.PagingModel;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 *
 * @author namph
 */
@Entity
@Table(name = "tbl_unit")
public class Unit extends PagingModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "unit_seq")
    @SequenceGenerator(name = "unit_seq", sequenceName = "tbl_unit_ID_seq", allocationSize = 50)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "NAME", nullable = true)
    private String name;
    @Column(name = "NOTE", nullable = true)
    private String note;
    @OneToMany(mappedBy = "unit", fetch = FetchType.LAZY)
    private List<Product> lstProduct = new ArrayList<Product>();

    @Transient
    private String relationName;
    @Transient
    private Integer unitId;

    public String getRelationName() {
        return relationName;
    }

    public void setRelationName(String relationName) {
        this.relationName = relationName;
    }

    @Override
    public void setPageCurrent(int pageCurrent) {
        super.setPageCurrent(pageCurrent); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int getPageCurrent() {
        return super.getPageCurrent(); //To change body of generated methods, choose Tools | Templates.
    }

    public Unit(Integer id, String name) {
        this.id = id;
        this.name = name;
    }

    public Integer getUnitId() {
        return unitId;
    }

    public void setUnitId(Integer unitId) {
        this.unitId = unitId;
    }

    public Unit() {
    }

    public Unit(Integer id) {
        this.id = id;
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

    public List<Product> getLstProduct() {
        return lstProduct;
    }

    public void setLstProduct(List<Product> lstProduct) {
        this.lstProduct = lstProduct;
    }
}
