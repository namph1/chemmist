/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.entity;

import com.namph.model.PagingModel;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 *
 * @author namph
 */
@Entity
@Table(name = "tbl_role")
public class Roles extends PagingModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "role_seq")
    @SequenceGenerator(name = "role_seq", sequenceName = "tbl_role_ID_seq", allocationSize = 50)
    @Column(name = "ID", unique = true, nullable = false)
    private Integer roleId;

    @Column(name = "ROLE_NAME", unique = true, nullable = false, length = 32)
    private String name;

    @Column(name = "NOTE", nullable = true, length = 255)
    private String note;

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(
            name = "tbl_role_menu",
            joinColumns = @JoinColumn(name = "\"role_id\""),
            inverseJoinColumns = @JoinColumn(name = "\"menu_id\"")
    )
    private Set<Menu> menus = new HashSet<>();

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(
            name = "tbl_role_menu_action",
            joinColumns = @JoinColumn(name = "\"role_id\""),
            inverseJoinColumns = @JoinColumn(name = "\"menu_action_id\"")
    )
    private Set<MenuAction> menusAction = new HashSet<>();

    @Transient
    private List<String> lstIdsMenu = new ArrayList<String>();

    public List<String> getLstIdsMenu() {
        return lstIdsMenu;
    }

    public void setLstIdsMenu(List<String> lstIdsMenu) {
        this.lstIdsMenu = lstIdsMenu;
    }

    public Set<Menu> getMenus() {
        return menus;
    }

    public void setMenus(Set<Menu> menus) {
        this.menus = menus;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public void setPageCurrent(int pageCurrent) {
        super.setPageCurrent(pageCurrent); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int getPageCurrent() {
        return super.getPageCurrent(); //To change body of generated methods, choose Tools | Templates.
    }

    public Set<MenuAction> getMenusAction() {
        return menusAction;
    }

    public void setMenusAction(Set<MenuAction> menusAction) {
        this.menusAction = menusAction;
    }

}
