<%-- 
    Document   : config
    Created on : Sep 21, 2017, 2:19:38 PM
    Author     : namph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="modal fade" id="objectConfig" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modalLabel"><label id="lblTitleAss" ></label></h4>
            </div>
            <div class="modal-body">
                <div class="form-group table-responsive">
                    <input type="hidden" id="empId"/>
                    <div id="divTbl2">
                        <div class="col-md-12">
                            <select multiple="multiple" size="30" name="duallistbox_demo2"
                                    id="selectAss"
                                    style="height: 200px;" class="demo2">
                                <c:if test="${not empty lstNoAss}">
                                    <c:forEach var="entity1" items="${lstNoAss}"
                                               varStatus="loopCounter">
                                        <option value="${entity1.id}">${entity1.code}${entity1.level}- ${entity1.name}- ${entity1.address}</option>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${not empty lstOfEmp}">
                                    <c:forEach var="entity2" items="${lstOfEmp}"
                                               varStatus="loopCounter">
                                        <option value="${entity2.id}" selected="selected">${entity2.code}${entity2.level}- ${entity2.name}- ${entity2.address}</option>
                                    </c:forEach>
                                </c:if>
                            </select>
                            <script>
                                var demo2 = $('.demo2').bootstrapDualListbox({
                                    nonSelectedListLabel: 'Đại lý chưa gán',
                                    selectedListLabel: 'Đại lý đã gán',
                                    preserveSelectionOnMove: 'moved',
                                    moveOnSelect: false,
                                    moveSelectedLabel: "Di chuyển đã chọn",
                                    filterPlaceHolder: 'Tên đại lý',
                                    infoText: 'Tất cả',
                                    infoTextFiltered: '<span class="label label-warning">Filtered</span> {0} from {1}',
                                    infoTextEmpty: "Không có dữ liệu"
                                });
                            </script>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <div class="pull-right">
                    <button type="submit" id="btn-add" class="btn btn-primary" onclick="onAssign();">
                        <i class="fa fa-check-square-o">Lưu</i>
                    </button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times">Đóng</i></button>
                </div>	
            </div>
        </div>
        <div class="tab-pane" id="access-security1">content 0</div>
    </div>
</div>