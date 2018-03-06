<%-- 
    Document   : assign
    Created on : Feb 13, 2018, 3:25:44 PM
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
                    <input type="hidden" id="roleId"/>
                    <input type="hidden" value='${menus}' id="ids"/>
                    <input type="hidden" value='${acts}' id="idsAct"/>
                    <div id="divTbl2">
                        <div id="treeview_container" class="hummingbird-treeview well h-scroll-large">
                            <ul id="treeview" class="hummingbird-base">
                                <c:forEach items="${allMenu}" var="menu">
                                    <li>  <c:if test="${menu.isParent == 1}">
                                            <i class="fa fa-plus"></i></c:if>
                                            <label>
                                                <input id="${menu.id}" data-id="${menu.id}" type="checkbox" />
                                            ${menu.name}
                                        </label>
                                        <c:if test="${menu.isParent == 1}">
                                            <ul>
                                                <c:forEach items="${menu.listMenu}" var="menuChild">
                                                    <li> <c:if test="${not empty menuChild.listMenuAction}">
                                                            <i class="fa fa-plus"></i></c:if>
                                                            <label>
                                                                <input
                                                                    id="${menu.id}-${menuChild.id}"
                                                                data-id="${menu.id}-${menuChild.id}" type="checkbox" />
                                                            ${menuChild.name}</label>
                                                            <c:if test="${not empty menuChild.listMenuAction}">
                                                            <ul>
                                                                <c:forEach items="${menuChild.listMenuAction}" var="menuAction">
                                                                    <li>
                                                                        <label>
                                                                            <input class="hummingbirdNoParent" 
                                                                                   id="${menu.id}--${menuChild.id}--${menuAction.id}"
                                                                                   data-id="${menu.id}--${menuChild.id}--${menuAction.id}" type="checkbox" />
                                                                            <i class="${menuAction.icon}"></i>
                                                                            ${menuAction.name}</label>
                                                                    </li>
                                                                </c:forEach>
                                                            </ul>
                                                        </c:if>
                                                    </li>
                                                </c:forEach>
                                            </ul> 
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </ul>
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
