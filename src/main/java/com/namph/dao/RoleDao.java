/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.Roles;
import java.util.List;

/**
 *
 * @author namph
 */
public interface RoleDao {

    List<Roles> getListRoles(Roles role);

    int getCount(Roles role);

    Roles getRoleById(Roles role);

    int insertRole(Roles role);

    int updateRole(Roles role);

    void assignMenu(Roles role);
}
