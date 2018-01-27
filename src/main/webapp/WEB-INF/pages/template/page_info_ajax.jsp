<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> 

<div class="row">
    <div class="form-inline">
        <div class="col-md-6">
            <div class="dataTables_info">
                <input type="hidden" id="pageSize" value="${pageInfo.direction}">
                <input type="hidden" id="totalRows" value="${pageInfo.totalRows}">
                <div class="col-md-3">${pageInfo.totalRowsTitle} ${pageInfo.totalRows}</div>
                <div class="col-md-3">${pageInfo.totalPagesTitle} ${pageInfo.totalPages}</div>
                <div class="col-md-6">
                    <div class="form-inline">
                            <label for="page">${pageInfo.goToPageTitle}</label>
                            <input type="number" name="page" id="page" 
                                   max="${pageInfo.totalPages}"
                                   value="${pageInfo.destPage}" 
                                   style="width: 20%"
                                   onchange="javascript:onGoPage(this.value);"/>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6" style="text-align: right">
            <div id="example1_paginate" class="dataTables_paginate"></div>
        </div>
    </div>
</div>

<script type="text/javascript">

    function showPageLink(curPage, numShowedPage, totalPage) {

        var strHtml = '<ul class="pagination pagination-sm">';
        if (totalPage <= numShowedPage) {
            for (var x = 1; x <= totalPage; x++) {
                strHtml += '<li id="li' + x + '"><a href="javascript:onGoPage(' + x + ');">' + x + '</a></li>';
            }
        } else {
            strHtml += '<li id="li1" ><a href="javascript:onGoPage(1);">Đầu</a></li>';
            var startPage = 1;
            var endPage = totalPage;

            var numBefore = Math.ceil(numShowedPage / 2);
            var numAfter = Math.ceil(numShowedPage / 2) - 1;
            if (curPage > numBefore) {
                startPage = curPage - numAfter;
            }

            if (curPage > (totalPage - numAfter)) {
                startPage = totalPage - numShowedPage + 1;
            }
            endPage = startPage + (numShowedPage - 1);

            if (endPage >= totalPage) {
                endPage = totalPage;
            }

            for (var x = startPage; x <= endPage; x++) {
                strHtml += '<li id="li' + x + '"><a href="javascript:onGoPage(' + x + ');">' + x + '</a></li>';
            }
            strHtml += '<li id="li' + totalPage + '"><a href="javascript:onGoPage(' + totalPage + ');">Cuối</a></li>';
        }
        strHtml += '</ul>';
        document.getElementById("example1_paginate").innerHTML = strHtml;
        $('#li' + '${pageInfo.destPage}').addClass('active');
    }

    showPageLink('${pageInfo.destPage}', 7, '${pageInfo.totalPages}');
</script>