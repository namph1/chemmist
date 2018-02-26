/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.model;

import com.namph.utils.Utils;
import java.util.Date;

/**
 *
 * @author namph
 */
public class CongNo extends PagingModel {

    private Integer customerId;
    private String customerCode;
    private String customerName;
    private String address;
    private Integer total;
    private String from;
    private String to;
    private String types;
    private Date createDate;
    private String onlyDate;
    private Float sanluong;
    private Integer type;
    private Integer sodudauky;
    private Integer phatsinhno;
    private Integer phatsinhco;
    private Integer provinceId;
    private Integer areaId;

    public Integer getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(Integer provinceId) {
        this.provinceId = provinceId;
    }

    public Integer getAreaId() {
        return areaId;
    }

    public void setAreaId(Integer areaId) {
        this.areaId = areaId;
    }

    public Integer getSodudauky() {
        if (sodudauky == null) {
            sodudauky = 0;
        }
        return sodudauky;
    }

    public void setSodudauky(Integer sodudauky) {
        this.sodudauky = sodudauky;
    }

    public Integer getPhatsinhno() {
        if (phatsinhno == null) {
            phatsinhno = 0;
        }
        return phatsinhno;
    }

    public void setPhatsinhno(Integer phatsinhno) {
        this.phatsinhno = phatsinhno;
    }

    public Integer getPhatsinhco() {
        if (phatsinhco == null) {
            phatsinhco = 0;
        }
        return phatsinhco;
    }

    public void setPhatsinhco(Integer phatsinhco) {
        this.phatsinhco = phatsinhco;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public Float getSanluong() {
        return sanluong;
    }

    public void setSanluong(Float sanluong) {
        this.sanluong = sanluong;
    }

    public String getOnlyDate() {
        if (createDate != null) {
            onlyDate = Utils.Date2DDMMYYY(createDate);
        }
        return onlyDate;
    }

    public void setOnlyDate(String onlyDate) {
        this.onlyDate = onlyDate;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getTypes() {
        if (types.equals("thu_tien_mat")) {
            types = "Thu tiền mặt";
        } else if (types.equals("xuatkho")) {
            types = "Xuất kho bán hàng";
        } else if (types.equals("chi_tien_mat")) {
            types = "Chi tiền mặt";
        } else if (types.equals("thu_chuyen_khoan")) {
            types = "Thu chuyển khoản";
        } else if (types.equals("chi_chuyen_khoan")) {
            types = "Chi chuyển khoản";
        } else if (types.equals("dau_ky")) {
            types = "Đầu kỳ";
        }
        return types;
    }

    public void setTypes(String types) {
        this.types = types;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
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
