/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.model;

/**
 *
 * @author namph
 */
public class TonKho extends PagingModel {

    private Integer productId;
    private Integer count;
    private String productName;
    private String productCode;
    private String unitName;
    private String fromDate;
    private String toDate;
    private Float weight;
    private Float sanluong;
    private Float sanluongXuat;
    private Float tondauky;

    public Float getSanluongXuat() {
        if (sanluongXuat == null) {
            sanluongXuat = 0f;
        }
        return sanluongXuat;
    }

    public void setSanluongXuat(Float sanluongXuat) {
        this.sanluongXuat = sanluongXuat;
    }

    public Float getSanluong() {
        if (sanluong == null) {
            sanluong = 0f;
        }
        return sanluong;
    }

    public void setSanluong(Float sanluong) {
        this.sanluong = sanluong;
    }

    public Float getWeight() {
        return weight;
    }

    public void setWeight(Float weight) {
        this.weight = weight;
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

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public Float getTondauky() {
        if (tondauky == null) {
            tondauky = 0f;
        }
        return tondauky;
    }

    public void setTondauky(Float tondauky) {
        this.tondauky = tondauky;
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
