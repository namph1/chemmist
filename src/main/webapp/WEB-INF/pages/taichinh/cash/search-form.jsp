<%-- 
    Document   : search-form
    Created on : Oct 14, 2017, 8:59:07 AM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title" id="modalLabel">
                        <i class="fa fa-list"></i> Tìm kiếm
                    </h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col col-md-2" >
                            <div class="form-group" >
                                <label>Từ ngày</label>
                                <div class="input-group date" id="datepicker1">
                                    <input type="text" class="form-control pull-right" id="fromDate" >
                                    <div class="input-group-addon">
                                        <i class="fa fa-th"></i>
                                    </div>
                                </div>
                                <!-- /.input group -->
                            </div>
                        </div>
                        <div class="col col-md-2" >
                            <div class="form-group" >
                                <label>Đến ngày</label>
                                <div class="input-group date" id="datepicker2">
                                    <input type="text" class="form-control pull-right" id="toDate" >
                                    <div class="input-group-addon">
                                        <i class="fa fa-th"></i>
                                    </div>
                                </div>
                                <!-- /.input group -->
                            </div>
                        </div>
                        <div class="col col-md-2" >
                            <div class="form-group">
                                <label>Mã đối tác</label>
                                <input type="text" class="form-control" id="code" placeholder="Mã khách hàng/ nhân viên"/>
                            </div>
                        </div>
                        <div class="col col-md-2" >
                            <div class="form-group">
                                <label>Hình thức</label>
                                <select id="status"
                                        class="form-control selectpicker" style="width: 100%;">
                                    <option value="-1">-- Tất cả --</option>
                                    <option value="0">Thu</option>
                                    <option value="1">Chi</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col col-md-3">
                            <button class="btn btn-primary btn-flat" id="btnSearch" onclick="onSearch(1);">
                                <i class="fa fa-search">Tìm kiếm</i>
                            </button>
                            <a class="btn btn-success btn-flat"
                               onclick="onExport();">
                                <i class="fa fa-file-excel-o"> Quỹ tiền mặt</i>
                            </a>
                        </div>
                        <div class="col col-md-9">
                            <div class="pull-right">
                                <div class="col col-md-6">
                                    <button class="btn btn-primary" 
                                            onclick="prepareAdd(0);">
                                        <i class="fa fa-arrow-down">Thu tiền</i>
                                    </button>
                                </div>
                                <div class="col col-md-6">
                                    <button class="btn btn-primary" 
                                            onclick="prepareAdd(1);">
                                        <i class="fa fa-arrow-up">Chi tiền</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="divTable">
        <%@include file="search-result.jsp" %>
    </div>
</section>
