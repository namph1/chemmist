/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.model.CongNo;
import com.namph.model.TonKho;
import java.util.List;

/**
 *
 * @author namph
 */
public interface TonKhoDao {

    List<TonKho> getListTonKho(String from, String to);

    List<CongNo> getListCongNo(Integer month, Integer year, String cusCode, Integer type);

    List<CongNo> getDetailCongNo(Integer month, Integer year, Integer cusId, Integer type);

    List<CongNo> getSanLuongOfSanPham(String from, String to, String code);
    
    List<CongNo> getSanLuongOfDaiLy(String from, String to, String code);
    
    List<CongNo> getSanLuongOfNhanvien(String from, String to, String code);
    
    List<CongNo> getSanLuongOfProvince(String from, String to, Integer provinceId, Integer areaId);
    
}
