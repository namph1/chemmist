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
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
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
import org.apache.commons.lang.StringUtils;

/**
 *
 * @author namph
 */
@Entity
@Table(name = "tbl_product")
public class Product extends PagingModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "product_seq")
    @SequenceGenerator(name = "product_seq", sequenceName = "tbl_product_ID_seq", allocationSize = 50)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "CODE")
    private String code;
    @Column(name = "NAME")
    private String name;
    @Column(name = "NOTE")
    private String note;
    @Column(name = "PRICE")
    private Float price;
    @Column(name = "PRICE_AU")
    private Float priceAu;
    @Column(name = "STATUS")
    private Integer status;
    @Column(name = "USER_ID")
    private Integer userId;
    @Column(name = "CREATED_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;
    @Column(name = "WEIGHT")
    private Float weight;
    @Column(name = "IMAGE")
    private String image;

    @ManyToOne
    @JoinColumn(name = "\"UNIT_ID\"", nullable = false)
    private Unit unit;

    @ManyToOne
    @JoinColumn(name = "\"PRODUCT_TYPE_ID\"", nullable = false)
    private GroupProduct group;

    @OneToMany(mappedBy = "product")
    private List<ImportDetail> lstImportDetail;

    @Transient
    private Integer unitId, exportDetailId, typeId;
    @Transient
    private Float count, total;
    @Transient
    private String sStatus, strDate, unitName, quy_cach;
    public Float getPriceAu() {
        return priceAu;
    }

    public void setPriceAu(Float priceAu) {
        this.priceAu = priceAu;
    }


    public String getImage() {
        if(!StringUtils.isEmpty(image)){
            image = Utils.convertFileImageToBase64Url(image);
        }
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
    public Integer getExportDetailId() {
        return exportDetailId;
    }

    public void setExportDetailId(Integer exportDetailId) {
        this.exportDetailId = exportDetailId;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public Float getTotal() {
        return total;
    }

    public void setTotal(Float total) {
        this.total = total;
    }

    public String getQuy_cach() {
        return quy_cach;
    }

    public void setQuy_cach(String quy_cach) {
        this.quy_cach = quy_cach;
    }

    public String getStrDate() {
        return strDate;
    }

    public void setStrDate(String strDate) {
        this.strDate = strDate;
    }

    public Float getCount() {
        if (count == null) {
            count = 0f;
        }
        return count;
    }

    public void setCount(Float count) {
        this.count = count;
    }

    public List<ImportDetail> getLstImportDetail() {
        return lstImportDetail;
    }

    public void setLstImportDetail(List<ImportDetail> lstImportDetail) {
        this.lstImportDetail = lstImportDetail;
    }

    public String getsStatus() {
        if (status != null) {
            switch (status) {
                case 0:
                    sStatus = "Tạm ngưng";
                    break;
                case 1:
                    sStatus = "Hoạt động";
                    break;
            }
        }
        return sStatus;
    }

    public void setsStatus(String sStatus) {
        this.sStatus = sStatus;
    }

    public Product() {
    }

    public Product(Integer id) {
        this.id = id;
    }

    public Product(String code) {
        this.code = code;
    }

    public Product(Integer id, String code, Integer status) {
        this.id = id;
        this.code = code;
        this.status = status;
    }

    public Product(Integer id, String code, String name, String note, Float price, Integer unitId, Integer typeId) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.note = note;
        this.price = price;
        this.unitId = unitId;
        this.typeId = typeId;
    }

    public Product(Integer id, String code, String name,
            String note, Float price, Integer unitId,
            Integer typeId, Float weight, Float priceAu) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.note = note;
        this.price = price;
        this.unitId = unitId;
        this.typeId = typeId;
        this.weight = weight;
        this.priceAu = priceAu;
    }

    public Integer getUnitId() {
        return unitId;
    }

    public void setUnitId(Integer unitId) {
        this.unitId = unitId;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNote() {
        String notes = note.replaceAll("(\r|\r\n|\n)", "<br/>");
        return notes;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
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

    public Unit getUnit() {
        return unit;
    }

    public void setUnit(Unit unit) {
        this.unit = unit;
    }

    public GroupProduct getGroup() {
        return group;
    }

    public void setGroup(GroupProduct group) {
        this.group = group;
    }

    public Float getWeight() {
        return weight;
    }

    public void setWeight(Float weight) {
        this.weight = weight;
    }

}
