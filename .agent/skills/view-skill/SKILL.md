---
name: view-skill
description: JSP 頁面架構，Java Server Page架構，以及參考JS or CSS架構。
---



# JSP 頁面開發規範：公版標籤與內容網頁標準

## 1. 專案資源路徑 (Resource Paths)
所有靜態資源應放置於 `webapp` 目錄下，路徑引用應使用 `${pageContext.request.contextPath}`：
- **CSS**: `webapp/css/` (包含 `bootstrap.min.css`, `sweetalert2.min.css`)
- **JS**: `webapp/js/` (包含 `vue.global.js`, `axios.min.js`, `sweetalert2.all.min.js`, `bootstrap.bundle.min.js`)

## 2. 基礎公版標籤 (`/WEB-INF/tags/base.tag`)
定義全域佈局、CSS/JS 框架資源與標準 HTML 結構。

```jsp
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="pageTitle" required="false" %>
<%@ attribute name="head_scripts" fragment="true" %>
<%@ attribute name="footer_scripts" fragment="true" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : '系統頁面'} - ProjectName</title>
    
    <!-- CSS 框架引用 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sweetalert2.min.css">
    
    <!-- Cyberpunk 風格或自定義樣式 -->
    <style>
        :root { --cyber-cyan: #00f0ff; --cyber-bg: #0d0208; }
        body { background-color: var(--cyber-bg); color: var(--cyber-cyan); }
    </style>
    
    <jsp:invoke fragment="head_scripts" />
</head>
<body>
    <div id="app" class="container mt-5">
        <!-- 內容網頁 (Content Page) 插入點 -->
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

## 3. 內容網頁實作基準 (Content Page Example)
內容網頁必須引用 `/WEB-INF/tags/` 下的標籤庫，並使用 `<t:base>` 作為裝飾器。

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:base pageTitle="技能展示頁面">
    <jsp:attribute name="head_scripts">
        <style>
            .content-card { border: 1px solid var(--cyber-cyan); padding: 20px; }
        </style>
    </jsp:attribute>

    <jsp:attribute name="footer_scripts">
        <script>
            const { createApp } = Vue;
            createApp({
                data() {
                    return { message: '這是透過 Vue 呈現的內容' }
                }
            }).mount('#app');
        </script>
    </jsp:attribute>

    <jsp:body>
        <div class="content-card shadow">
            <h2>{{ message }}</h2>
            <p>此頁面為內容網頁，已成功套用 base.tag 公版。</p>
        </div>
    </jsp:body>
</t:base>
```
