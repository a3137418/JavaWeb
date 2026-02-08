<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:base pageTitle="會員註冊 - MyWeb">
    <jsp:attribute name="head_scripts">
        <style>
            .register-container {
                max-width: 400px;
                margin: 2rem auto;
                padding: 2.5rem;
                background: white;
                border-radius: 1.5rem;
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                margin-bottom: 2rem;
                font-weight: 700;
                color: #111827;
            }
        </style>
    </jsp:attribute>

    <jsp:body>
        <div class="register-container">
            <h1>會員註冊</h1>
            <form action="${pageContext.request.contextPath}/register" method="POST">
                <div class="mb-3">
                    <label for="account" class="form-label">使用者帳號</label>
                    <input type="text" class="form-control" id="account" name="account" placeholder="請輸入帳號" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">使用者密碼</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="請輸入密碼" required>
                </div>
                <div class="mb-3">
                    <label for="realName" class="form-label">真實姓名</label>
                    <input type="text" class="form-control" id="realName" name="realName" placeholder="請輸入您的真實姓名" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">電子信箱</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="example@domain.com" required>
                </div>
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">立即註冊</button>
                </div>
            </form>
            <div class="text-center mt-3">
                已經有帳號了？ <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">登入</a>
            </div>
        </div>

        <script>
            const { createApp } = Vue;
            createApp({
                data() {
                    return {}
                }
            }).mount('#app');
        </script>
    </jsp:body>
</t:base>
