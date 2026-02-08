<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>

            <t:base pageTitle="會員註冊">
                <jsp:attribute name="head_scripts">
                    <style>
                        .register-card {
                            max-width: 500px;
                            margin: auto;
                            border-radius: 15px;
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                        }

                        .card-header {
                            background-color: #0d6efd;
                            color: white;
                            border-radius: 15px 15px 0 0 !important;
                            text-align: center;
                            padding: 1.5rem;
                        }
                    </style>
                </jsp:attribute>

                <jsp:attribute name="footer_scripts">
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const passwordInput = document.getElementById('password');
                            const pwdError = document.getElementById('pwdError');

                            passwordInput.addEventListener('blur', function () {
                                const password = this.value;
                                let errors = [];

                                if (password.length < 6 || password.length > 12) errors.push('長度必須在 6-12 字元之間');
                                if (!/[A-Z]/.test(password)) errors.push('必須包含至少一個大寫英文字元');
                                if (!/[a-z]/.test(password)) errors.push('必須包含至少一個小寫英文字元');
                                if (!/[0-9]/.test(password)) errors.push('必須包含至少一個數字');
                                if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) errors.push('必須包含至少一個特殊符號');

                                if (errors.length > 0) {
                                    this.classList.add('is-invalid');
                                    this.classList.remove('is-valid');
                                    pwdError.textContent = errors.join('；');
                                } else {
                                    this.classList.remove('is-invalid');
                                    this.classList.add('is-valid');
                                    pwdError.textContent = '';
                                }
                            });
                        });
                    </script>
                </jsp:attribute>

                <jsp:body>
                    <div class="card register-card">
                        <div class="card-header">
                            <h3 class="mb-0">會員註冊</h3>
                        </div>
                        <div class="card-body p-4">
                            <form method="post">
                                <div class="mb-3">
                                    <label for="userid" class="form-label">使用者帳號</label>
                                    <input type="text" class="form-control" id="userid" name="userid"
                                        placeholder="請輸入帳號" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">密碼</label>
                                    <input type="password" class="form-control" id="password" name="password"
                                        placeholder="請輸入密碼" required>
                                    <div id="pwdError" class="invalid-feedback"></div>
                                </div>
                                <div class="mb-3">
                                    <label for="realname" class="form-label">真實姓名</label>
                                    <input type="text" class="form-control" id="realname" name="realname"
                                        placeholder="請輸入真實姓名" required>
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">電子郵件信箱</label>
                                    <input type="email" class="form-control" id="email" name="email"
                                        placeholder="example@domain.com" required>
                                </div>
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg">立即註冊</button>
                                    <button type="reset" class="btn btn-outline-secondary">取消</button>
                                </div>
                            </form>

                            <c:if test="${not empty msg}">
                                <div class="alert alert-info mt-4 text-center">
                                    ${msg}
                                </div>
                            </c:if>
                        </div>
                    </div>
                </jsp:body>
            </t:base>