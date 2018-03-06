/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.model;

import com.namph.entity.Menu;
import com.namph.entity.MyUser;
import com.namph.entity.Roles;
import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Set;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

/**
 *
 * @author namph
 */
public class UserCustomImpl extends User implements Serializable {

    private Integer userId;
    private MyUser users;
    private Set<Roles> roles;
    private List<Menu> listMenu;

    public UserCustomImpl(MyUser users, List<Menu> lstMenu, Collection<? extends GrantedAuthority> authorities) {
        super(users.getName(), users.getPassword(), authorities);
        this.userId = users.getUserId();
        this.users = users;
        this.roles = users.getRoles();
        this.listMenu = lstMenu;
    }

    public List<Menu> getListMenu() {
        return listMenu;
    }

    public void setListMenu(List<Menu> listMenu) {
        this.listMenu = listMenu;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public MyUser getUsers() {
        return users;
    }

    public void setUsers(MyUser users) {
        this.users = users;
    }

    public Set<Roles> getRoles() {
        return roles;
    }

    public void setRoles(Set<Roles> roles) {
        this.roles = roles;
    }

}
