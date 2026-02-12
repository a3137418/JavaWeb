<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="pageTitle" required="false" %>
<%@ attribute name="head_scripts" fragment="true" %>
<%@ attribute name="footer_scripts" fragment="true" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : '客戶資料管理系統'} - Cyberpunk</title>
    
    <!-- CSS 框架引用 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sweetalert2.min.css">
    
    <style>
        :root {
            --cyber-pink: #ff003c;
            --cyber-cyan: #00f0ff;
            --cyber-purple: #bc13fe;
            --cyber-bg: #0d0208;
            --cyber-dark: #1a1a1a;
        }

        body {
            background-color: var(--cyber-bg);
            color: var(--cyber-cyan);
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            overflow-x: hidden;
            background-image: linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.25) 50%), linear-gradient(90deg, rgba(255, 0, 0, 0.06), rgba(0, 255, 0, 0.02), rgba(0, 0, 255, 0.06));
            background-size: 100% 2px, 3px 100%;
        }

        .navbar {
            background-color: var(--cyber-dark) !important;
            border-bottom: 2px solid var(--cyber-pink);
            box-shadow: 0 0 15px var(--cyber-pink);
        }

        .navbar-brand {
            color: var(--cyber-pink) !important;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 0 0 10px var(--cyber-pink);
        }

        .nav-link {
            color: var(--cyber-cyan) !important;
            transition: all 0.3s;
            position: relative;
        }

        .nav-link:hover {
            color: var(--cyber-pink) !important;
            text-shadow: 0 0 8px var(--cyber-pink);
        }

        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: var(--cyber-pink);
            transition: width 0.3s;
        }

        .nav-link:hover::after {
            width: 100%;
        }

        .cyber-card {
            background: rgba(26, 26, 26, 0.9);
            border: 1px solid var(--cyber-cyan);
            box-shadow: 5px 5px 0px var(--cyber-pink);
            padding: 20px;
            margin-top: 20px;
        }

        .glitch-text {
            position: relative;
            display: inline-block;
        }

        h1, h2, h3 {
            color: var(--cyber-cyan);
            text-shadow: 0 0 5px var(--cyber-cyan);
        }

        footer {
            border-top: 1px solid var(--cyber-purple);
            padding: 20px 0;
            margin-top: 50px;
            color: var(--cyber-purple);
            text-align: center;
        }
    </style>
    
    <jsp:invoke fragment="head_scripts" />
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark px-4">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            客戶資料管理系統
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/customers">客戶資料查詢</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/spa">SPA頁面應用</a>
                </li>
            </ul>
        </div>
    </nav>

    <div id="app" class="container mt-5">
        <!-- 頁面內容(Content Page)插入點 -->
        <jsp:doBody />
    </div>

    <footer>
        <p>&copy; 2026 巨匠電腦 - Cyberpunk System | <span>Design by Eric Chen</span></p>
    </footer>

    <!-- JS 框架引用 (Vue 3, Axios, SweetAlert2, Bootstrap) -->
    <script src="${pageContext.request.contextPath}/js/vue.global.js"></script>
    <script src="${pageContext.request.contextPath}/js/axios.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/sweetalert2.all.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    
    <jsp:invoke fragment="footer_scripts" />
</body>
</html>
