/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.Import;
import java.util.Date;
import java.util.List;

/**
 *
 * @author namph
 */
public interface ImportDao {

    List<Import> getListImport(Import imp);

    public int getCount(Import imp);

    int getMaxNoByMonth(Import imp);
    
    int insertImp(Import imp);
    
    Import getImpById(Import imp);
    
    int deleteImp(Import imp);
    
    int deleteImpDauKy(Date from, Date to);
}
