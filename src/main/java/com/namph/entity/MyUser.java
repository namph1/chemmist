/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.entity;

import com.namph.model.PagingModel;
import com.namph.utils.Utils;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 *
 * @author namph
 */
@Entity
@Table(name = "tbl_users")
public class MyUser extends PagingModel implements Serializable {

    @Id
    @Column(name = "ID", unique = true, nullable = false)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_seq")
    @SequenceGenerator(name = "user_seq", sequenceName = "tbl_users_ID_seq", allocationSize = 50)
    private Integer userId;

    @Column(name = "USER_NAME", unique = true, nullable = false, length = 32)
    private String name;

    @Column(name = "PASS", nullable = false, length = 255)
    private String password;

    @Column(name = "FULL_NAME", nullable = true, length = 255)
    private String fullName;

    @Column(name = "STATUS", nullable = false)
    private Integer active;

    @Column(name = "IS_ADMIN", nullable = false, length = 1)
    private Integer isAdmin;

    @Column(name = "EMAIL", nullable = false, length = 255)
    private String email;

    @Column(name = "POSITION", nullable = false, length = 255)
    private String position;

    @Column(name = "PHONE", nullable = false, length = 255)
    private String phone;

    @Column(name = "CREATE_DATE")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdDate;

    @Transient
    private String strCreateDate, sStatus, strRoleId;

    @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinTable(
            name = "tbl_user_role",
            joinColumns = @JoinColumn(name = "\"USER_ID\""),
            inverseJoinColumns = @JoinColumn(name = "\"ROLE_ID\"")
    )
    private Set<Roles> roles = new HashSet<>();

    public String getsStatus() {
        if (active != null) {
            switch (active) {
                case 0:
                    sStatus = "Tạm dừng";
                    break;
                case 1:
                    sStatus = "Đang hoạt động";
                    break;
            }
        }
        return sStatus;
    }

    public void setsStatus(String sStatus) {
        this.sStatus = sStatus;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Integer getActive() {
        return active;
    }

    public void setActive(Integer active) {
        this.active = active;
    }

    public Set<Roles> getRoles() {
        return roles;
    }

    public void setRoles(Set<Roles> roles) {
        this.roles = roles;
    }

    public Integer getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(Integer isAdmin) {
        this.isAdmin = isAdmin;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getStrCreateDate() {
        if (createdDate != null) {
            strCreateDate = Utils.Date2DDMMYYY(createdDate);
        }
        return strCreateDate;
    }

    public void setStrCreateDate(String strCreateDate) {
        this.strCreateDate = strCreateDate;
    }

    @Override
    public void setPageCurrent(int pageCurrent) {
        super.setPageCurrent(pageCurrent); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int getPageCurrent() {
        return super.getPageCurrent(); //To change body of generated methods, choose Tools | Templates.
    }

    public String getStrRoleId() {
        return strRoleId;
    }

    public void setStrRoleId(String strRoleId) {
        this.strRoleId = strRoleId;
    }

    
}
