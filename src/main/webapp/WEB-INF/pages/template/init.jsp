<%-- 
    Document   : init
    Created on : Sep 14, 2017, 11:06:31 AM
    Author     : namph
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
    <title>${titlePage}</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" >
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminLte/css/AdminLTE.min.css"/>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminLte/css/skins/_all-skins.min.css">
    <link  type="text/css" rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-bootgrid/1.3.1/jquery.bootgrid.css">-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminLte/css/daterangepicker.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminLte/css/bootstrap-datepicker.min.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminLte/css/bootstrap3-wysihtml5.min.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/adminLte/css/jquery-jvectormap.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.growl.css">
    <!--<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notification.css">-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.css">
    <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.4/css/select2.css" rel="stylesheet" />-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/iCheck/all.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/dual_listbox/bootstrap-duallistbox.css">
    <link href="http://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css"/>
    <!--<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css"/>-->
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/my_style.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/autocomplete/easy-autocomplete.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/autocomplete/easy-autocomplete.themes.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/tree/hummingbird-treeview.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/adminlte.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/pages/dashboard.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/demo.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.growl.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/jquery.slimscroll.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/jquery.sparkline.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/jquery-jvectormap-1.2.2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/jquery-jvectormap-world-mill-en.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/jquery.knob.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/bootstrap-datepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/bootstrap-datepicker.vi.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/daterangepicker.js"></script>
    <script src="${pageContext.request.contextPath}/resources/adminLte/js/bootstrap3-wysihtml5.all.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-bootgrid/1.3.1/jquery.bootgrid.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/bootstrap-select.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.0/jquery-confirm.min.js"></script>
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.4/js/select2.full.min.js"></script>-->
    <script src="${pageContext.request.contextPath}/resources/iCheck/icheck.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/autocomplete/jquery.easy-autocomplete.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dual_listbox/jquery.bootstrap-duallistbox.js"></script>
    <script src="${pageContext.request.contextPath}/resources/tree/hummingbird-treeview.js"></script>
    <script type="text/javascript" src="http://cdn.peerjs.com/0/peer.js"></script>
    <!--<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>-->
    <style>
        label.required::after {
            content: '(*)';
            margin-right: 4px;
            color: red;
        }
        .dataTables_paginate {
            margin: 0;
            white-space: nowrap;
            text-align: right;
        }

        .dataTables_paginate ul.pagination {
            margin: 2px 0;
            white-space: nowrap;
        }
    </style>

    <script type="text/javascript">
        function showMessage(content, type) {
            if (type == "ERROR") {
                $.growl.error({message: content});
//                $.notification.show('error', content);
            } else if (type == "NOTICE") {
                $.growl.notice({message: content});
//                $.notification.show('info', content);
            } else if (type == 'WARNING') {
//                $.notification.show('other', content);
                $.growl.warning({message: content});
            } else if (type == 'SUCCESS') {
//                $.notification.show('success', content);
                $.growl({title: "SUCCESS", message: content});
            }

        }

        function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        }
        function numberWithDots(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        function showDetailMess(title, note) {
            $.alert({
                theme: 'material',
                animationSpeed: 200,
                animationBounce: 1.5,
                type: 'blue',
                icon: 'fa fa-info',
                typeAnimated: true,
                closeIcon: true,
                title: title,
                content: note
            });
        }

        function ucword(str) {
            str = str.toLowerCase();
            return str.replace(/(^([a-zA-Z\p{M}]))|([ -][a-zA-Z\p{M}])/g,
                    function (s) {
                        return s.toUpperCase();
                    });
        }

        function isFloat(val) {
            var floatRegex = /^-?\d+(?:[.,]\d*?)?$/;
            if (!floatRegex.test(val))
                return false;

            val = parseFloat(val);
            if (isNaN(val))
                return false;
            return true;
        }

        Number.prototype.format = function (n, x) {
            var re = '(\\d)(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
            return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$1,');
        };

        String.prototype.replaceAll = function (target, replacement) {
            return this.split(target).join(replacement);
        };

        var conn;
        // Connect to PeerJS, have server assign an ID instead of providing one
        var name = '<%= session.getAttribute("userName")%>';
        var peer = new Peer(name, {key: 'b0l2fzya333j714i', debug: true, allow_discovery: true});
        peer.on('open', function (id) {
        });

        peer.on('connection', connect);
        function connect(c) {
            conn = c;
            // nhan tin nhan
            conn.on('data', function (data) {
                alert(conn.peer + ': ' + data);
                conn.send("hello");
            });
            //khi ngat ket noi
            conn.on('close', function (err) {
                alert(conn.peer + ' has left the chat.');
            });
        }
    </script>   
</head>
