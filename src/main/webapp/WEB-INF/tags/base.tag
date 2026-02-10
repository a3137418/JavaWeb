<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="pageTitle" required="false" %>
<%@ attribute name="head_scripts" fragment="true" %>
<%@ attribute name="footer_scripts" fragment="true" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>專案系統 - ${not empty pageTitle ? pageTitle : 'MyWeb'}</title>
    
    <!-- CSS 框架引用 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sweetalert2.min.css">
    
    <jsp:invoke fragment="head_scripts" />
</head>
<body>
    <div id="app" class="container mt-5">
        <!-- 頁面內容(Content Page)插入點 -->
        <jsp:doBody />
    </div>

    <!-- JS 框架引用 (Vue 3, Axios, SweetAlert2, Bootstrap) -->
    <script src="${pageContext.request.contextPath}/js/vue.global.js"></script>
    <script src="${pageContext.request.contextPath}/js/axios.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/sweetalert2.all.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    
    <jsp:invoke fragment="footer_scripts" />
    <h3>巨匠電腦-john</h3>
</body>
</html>
