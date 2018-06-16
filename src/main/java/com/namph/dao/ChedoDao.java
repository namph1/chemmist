/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.CheDo;
import java.util.List;

/**
 *
 * @author namph
 */
public interface ChedoDao {
    List<CheDo> getListChedo(CheDo chedo);
    
    int getCountChedo(CheDo chedo);
    
    int insertChedo(List<CheDo> lstObj);
    
    int updateChedo(CheDo chedo);
    
    int insertOneCheDo(CheDo chedo);
    
    CheDo getCheDo(int id);
}
