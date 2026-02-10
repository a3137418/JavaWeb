<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>

            <t:base pageTitle="會員註冊 - MyWeb">
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

                <jsp:body>
                    <div class="card register-card">
                        <div class="card-header">
                            <h3 class="mb-0">會員註冊</h3>
                        </div>
                        <div class="card-body p-4">
                            <form method="post" @submit="validateForm">
                                <div class="mb-3">
                                    <label for="userid" class="form-label">使用者帳號</label>
                                    <input type="text" class="form-control" id="userid" name="userid"
                                        placeholder="請輸入帳號" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">密碼</label>
                                    <input type="password" class="form-control"
                                        :class="{'is-invalid': errors.password.length > 0}" id="password"
                                        name="password" placeholder="請輸入密碼" required @blur="validatePassword"
                                        v-model="password">
                                    <div class="invalid-feedback" v-if="errors.password.length > 0">
                                        <div v-for="err in errors.password">{{ err }}</div>
                                    </div>
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
                                    <button type="reset" class="btn btn-outline-secondary"
                                        @click="resetForm">取消</button>
                                </div>
                            </form>

                            <c:if test="${not empty msg}">
                                <div class="alert alert-info mt-4 text-center">
                                    ${msg}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <script>
                        const { createApp } = Vue;
                        createApp({
                            data() {
                                return {
                                    password: '',
                                    errors: {
                                        password: []
                                    }
                                }
                            },
                            methods: {
                                validatePassword() {
                                    this.errors.password = [];
                                    const pwd = this.password;
                                    if (pwd.length < 6 || pwd.length > 12) {
                                        this.errors.password.push('密碼長度必須在 6-12 字元之間 (含)');
                                    }
                                    if (!/[A-Z]/.test(pwd)) {
                                        this.errors.password.push('至少需要一個英文大寫字母');
                                    }
                                    if (!/[a-z]/.test(pwd)) {
                                        this.errors.password.push('至少需要一個英文小寫字母');
                                    }
                                    if (!/[0-9]/.test(pwd)) {
                                        this.errors.password.push('至少需要一個數字');
                                    }
                                    if (!/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(pwd)) {
                                        this.errors.password.push('至少需要一個特殊符號 (!@#$%^&*等)');
                                    }
                                },
                                validateForm(e) {
                                    this.validatePassword();
                                    if (this.errors.password.length > 0) {
                                        e.preventDefault();
                                        Swal.fire({
                                            title: '驗證失敗',
                                            text: '請修正密碼錯誤後再提交',
                                            icon: 'error'
                                        });
                                    }
                                },
                                resetForm() {
                                    this.password = '';
                                    this.errors.password = [];
                                }
                            }
                        }).mount('#app');
                    </script>
                </jsp:body>
            </t:base>