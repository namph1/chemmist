/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.entity;

import com.namph.model.PagingModel;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

/**
 *
 * @author namph
 */
@Entity
@Table(name = "tbl_menu")
public class Menu extends PagingModel implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "menu_seq")
    @SequenceGenerator(name = "menu_seq", sequenceName = "tbl_menu_ID_seq", allocationSize = 50)
    @Column(name = "ID")
    private Integer id;
    @Column(name = "NAME")
    private String name;
    @Column(name = "URL")
    private String url;
    @OneToMany(mappedBy = "menu", fetch = FetchType.LAZY)
    private List<Menu> listMenu = new ArrayList<Menu>();
    @ManyToOne
    @JoinColumn(name = "\"PARENT_ID\"", nullable = true)
    private Menu menu;

    @Column(name = "ORDERS")
    private Integer orders;
    @Column(name = "ICON")
    private String icon;
    @Column(name = "IS_PARENT")
    private Integer isParent;

    @OneToMany(mappedBy = "menus", fetch = FetchType.EAGER)
    private List<MenuAction> listMenuAction = new ArrayList<MenuAction>();

    public Integer getIsParent() {
        return isParent;
    }

    public void setIsParent(Integer isParent) {
        this.isParent = isParent;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public List<Menu> getListMenu() {
        return listMenu;
    }

    public void setListMenu(List<Menu> listMenu) {
        this.listMenu = listMenu;
    }

    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public Integer getOrders() {
        return orders;
    }

    public void setOrders(Integer orders) {
        this.orders = orders;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 67 * hash + Objects.hashCode(this.id);
        hash = 67 * hash + Objects.hashCode(this.name);
        hash = 67 * hash + Objects.hashCode(this.url);
        hash = 67 * hash + Objects.hashCode(this.orders);
        hash = 67 * hash + Objects.hashCode(this.icon);
        hash = 67 * hash + Objects.hashCode(this.isParent);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Menu other = (Menu) obj;
        if (!Objects.equals(this.name, other.name)) {
            return false;
        }
        if (!Objects.equals(this.url, other.url)) {
            return false;
        }
        if (!Objects.equals(this.icon, other.icon)) {
            return false;
        }
        if (!Objects.equals(this.id, other.id)) {
            return false;
        }
        if (!Objects.equals(this.orders, other.orders)) {
            return false;
        }
        if (!Objects.equals(this.isParent, other.isParent)) {
            return false;
        }
        return true;
    }

    public static SortedSet<Menu> sortByOrders(Set<Menu> menus) {
        TreeSet<Menu> sortedHouses = new TreeSet<Menu>(
                new Comparator<Menu>() {
            @Override
            public int compare(Menu o1, Menu o2) {
                return o1.getOrders().compareTo(o2.getOrders());
            }
        });
        sortedHouses.addAll(menus);
        return sortedHouses;
    }

    public List<MenuAction> getListMenuAction() {
        return listMenuAction;
    }

    public void setListMenuAction(List<MenuAction> listMenuAction) {
        this.listMenuAction = listMenuAction;
    }

}
