/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.GroupProduct;
import java.util.List;

/**
 *
 * @author namph
 */
public interface GroupDao {

    public List<GroupProduct> getListProduct(GroupProduct group);
    
     public int getCount(GroupProduct group);

    public int edit(GroupProduct group);

    public int add(GroupProduct group);
    
    public GroupProduct getGroup(GroupProduct group);
}
