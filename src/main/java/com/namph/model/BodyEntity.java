package com.namph.model;

import java.io.Serializable;

public class BodyEntity implements Serializable {

    private Integer id;
    private String name;
    private Integer idParent;
    private String name2;

    public BodyEntity() {
        super();
    }

    public BodyEntity(Integer id, String name) {
        super();
        this.id = id;
        this.name = name;
    }

    public BodyEntity(Integer id, String name, String name2) {
        this.id = id;
        this.name = name;
        this.name2 = name2;
    }

    public BodyEntity(Integer id, String name, Integer idParent) {
        super();
        this.id = id;
        this.name = name;
        this.idParent = idParent;
    }

    public String getName2() {
        return name2;
    }

    public void setName2(String name2) {
        this.name2 = name2;
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

    public Integer getIdParent() {
        return idParent;
    }

    public void setIdParent(Integer idParent) {
        this.idParent = idParent;
    }

}
