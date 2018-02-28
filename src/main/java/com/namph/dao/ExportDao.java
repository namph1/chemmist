/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.Export;
import java.util.List;

/**
 *
 * @author namph
 */
public interface ExportDao {

    int getCount(Export exp);

    List<Export> getListByCondition(Export exp);

    int deleteExp(Export exp);

    Export getExpById(Export imp);

    int getMaxNoByMonth(Export emp);
    
    int insertExp(Export emp) throws Exception;
    
    int updateExp(Export emp) throws Exception;
    
    int getCountFromTo(Export exp);
}
