/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.model;

import com.namph.utils.CONSTANT;
import javax.persistence.Transient;

/**
 *
 * @author namph
 */
public class PagingModel {

    @Transient
    private int pageSize = CONSTANT.PAGE_SIZE;
    @Transient
    private int pageCurrent;

    public int getPageCurrent() {
        return pageCurrent;
    }

    public void setPageCurrent(int pageCurrent) {
        this.pageCurrent = pageCurrent;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

}
