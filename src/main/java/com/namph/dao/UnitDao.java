/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.Unit;
import java.util.List;

/**
 *
 * @author namph
 */
public interface UnitDao {
    public List<Unit> getListUnit(Unit unit);
    
    public int getCount(Unit unit);
    
    public int edit(Unit unit);
    
    public int add(Unit unit);
}
