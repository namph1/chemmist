/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.Menu;
import com.namph.entity.MenuAction;
import java.util.List;
import java.util.Set;

/**
 *
 * @author namph
 */
public interface MenuDao {

    List<Menu> getAllMenu();

    Set<Menu> getListMenuByRole(Integer roleId);
    
    List<MenuAction> getallActionMenu();
    
}
