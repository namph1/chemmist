/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.MyUser;
import com.namph.entity.Roles;
import java.util.List;
import java.util.Set;

/**
 *
 * @author namph
 */
public interface UserDao {

    MyUser findUserByUserName(String userName);

    int getCount(MyUser user);

    List<MyUser> getListUser(MyUser user);

    int addUser(MyUser user);

    int editUser(MyUser user);

    MyUser getUserById(MyUser user);

    List<Roles> getAllRoles(MyUser user);

    Set<Roles> getRolesUser(MyUser users);
    
    void assignRole(MyUser users);

}
