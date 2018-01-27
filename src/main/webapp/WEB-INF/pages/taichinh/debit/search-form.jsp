<%-- 
    Document   : search-form
    Created on : Oct 23, 2017, 9:50:56 AM
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
                        <div class="col col-md-3" >
                            <div class="form-group" >
                                <label>Thời gian</label>
                                <div class="input-group date" id="datepicker1">
                                    <input type="text" class="form-control pull-right" id="fromDate" >
                                    <div class="input-group-addon">
                                        <i class="fa fa-th"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col col-md-3" >
                            <div class="form-group">
                                <label>Mã khách hàng</label>
                                <input type="text" class="form-control" id="code" placeholder="Mã khách hàng: ..."/>
                            </div>
                        </div>
                        <div class="col col-md-3" >
                            <div class="form-group">
                                <label>Đối tượng</label>
                                <select id="type"
                                        class="form-control selectpicker" style="width: 100%;">
                                    <option value="-1">-- Tất cả --</option>
                                    <option value="0">Khách hàng</option>
                                    <option value="1">Nhân viên</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col col-md-6">
                            <button class="btn btn-primary btn-flat" id="btnSearch" onclick="onSearch(1);">
                                <i class="fa fa-search">Tìm kiếm</i>
                            </button>
                            <a class="btn btn-success btn-flat"
                               onclick="onExport();">
                                <i class="fa fa-file-excel-o"> Xuất excel</i>
                            </a>
                             <a class="btn btn-bitbucket btn-flat"
                               onclick="onRefresh();">
                                <i class="fa fa-refresh"> Chốt sổ</i>
                            </a>
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
