---
name: view-skill
description: JSP 頁面架構，Java Server Page架構，以及參考JS or CSS架構。
---



# JSP 頁面開發規範：公版架構與前端框架整合

## 1. 專案資源路徑 (Resource Paths)
所有靜態資源應放置於 `webapp` 目錄下：
- **CSS**: `webapp/css/` (包含 `bootstrap.min.css`, `sweetalert2.min.css`)
- **JS**: `webapp/js/` (包含 `vue.global.js`, `axios.min.js`, `sweetalert2.all.min.js`, `bootstrap.bundle.min.js`)

## 2. 基礎公版架構 (`/WEB-INF/layouts/base.jsp`)
定義全域引用的框架資源與標準 HTML 結構。

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>專案系統 - <jsp:getProperty name="pageTitle" property="value" /></title>
    
    <!-- CSS 框架引用 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sweetalert2.min.css">
    
    <jsp:invoke fragment="head_scripts" />
</head>
<body>
    <div id="app" class="container mt-5">
        <!-- 頁面內容插入點 -->
        <jsp:doBody />
    </div>

    <!-- JS 框架引用 (Vue 3, Axios, SweetAlert2, Bootstrap) -->
    <script src="${pageContext.request.contextPath}/js/vue.global.js"></script>
    <script src="${pageContext.request.contextPath}/js/axios.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/sweetalert2.all.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    
    <jsp:invoke fragment="footer_scripts" />
</body>
</html>
```

## 3. 內容頁面實作範例 (`/pages/skill-demo.jsp`)
採用 `base.jsp` 作為裝飾器，並實作 Vue.js 邏輯。

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:base>
    <jsp:attribute name="head_scripts">
        <style>
            .demo-card { border-radius: 15px; }
        </style>
    </jsp:attribute>

    <jsp:body>
        <div class="card demo-card shadow">
            <div class="card-header bg-primary text-white">
                <h4>{{ title }}</h4>
            </div>
            <div class="card-body">
                <p class="card-text">{{ description }}</p>
                <button @click="fetchData" class="btn btn-outline-primary">
                    使用 Axios 取得資料
                </button>
            </div>
        </div>

        <script>
            const { createApp } = Vue;
            createApp({
                data() {
                    return {
                        title: 'JSP + Vue 整合規範',
                        description: '此頁面已成功載入 Bootstrap 與 Vue 框架。'
                    }
                },
                methods: {
                    async fetchData() {
                        try {
                            // Axios 範例
                            // const response = await axios.get('/api/data');
                            Swal.fire({
                                title: '成功',
                                text: 'SweetAlert2 與 Axios 整合正常',
                                icon: 'success'
                            });
                        } catch (error) {
                            Swal.fire('錯誤', '資料讀取失敗', 'error');
                        }
                    }
                }
            }).mount('#app');
        </script>
    </jsp:body>
</t:base>
```