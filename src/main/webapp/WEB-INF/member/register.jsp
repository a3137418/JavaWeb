<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

                <t:base pageTitle="會員註冊">
                    <jsp:attribute name="head_scripts">
                        <style>
                            /* ===== 註冊頁面專屬樣式（Cyberpunk 風格 — 與登入頁一致） ===== */
                            .register-wrapper {
                                min-height: 80vh;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                            }

                            .register-card {
                                background: rgba(13, 2, 8, 0.92);
                                border: 1px solid var(--cyber-cyan);
                                box-shadow: 0 0 30px rgba(0, 240, 255, 0.2), 5px 5px 0px var(--cyber-pink);
                                padding: 3rem 2.5rem;
                                width: 100%;
                                max-width: 500px;
                                position: relative;
                                overflow: hidden;
                            }

                            /* 裝飾性頂部橫條 */
                            .register-card::before {
                                content: '';
                                position: absolute;
                                top: 0;
                                left: 0;
                                right: 0;
                                height: 4px;
                                background: linear-gradient(90deg, var(--cyber-cyan), var(--cyber-purple), var(--cyber-pink));
                            }

                            /* 背景掃描線動畫 */
                            .register-card::after {
                                content: '';
                                position: absolute;
                                top: -100%;
                                left: 0;
                                right: 0;
                                height: 100%;
                                background: linear-gradient(transparent 50%, rgba(0, 240, 255, 0.03) 50%);
                                background-size: 100% 4px;
                                animation: scanlines 8s linear infinite;
                                pointer-events: none;
                            }

                            @keyframes scanlines {
                                0% {
                                    top: -100%;
                                }

                                100% {
                                    top: 100%;
                                }
                            }

                            .register-title {
                                font-size: 1.8rem;
                                font-weight: 700;
                                color: var(--cyber-cyan);
                                text-shadow: 0 0 12px var(--cyber-cyan);
                                text-align: center;
                                letter-spacing: 4px;
                                text-transform: uppercase;
                                margin-bottom: 0.3rem;
                            }

                            .register-subtitle {
                                text-align: center;
                                color: var(--cyber-purple);
                                font-size: 0.8rem;
                                letter-spacing: 2px;
                                margin-bottom: 2rem;
                                opacity: 0.8;
                            }

                            .register-divider {
                                border: none;
                                border-top: 1px solid var(--cyber-cyan);
                                opacity: 0.4;
                                margin: 1.5rem 0;
                            }

                            /* 輸入框群組 */
                            .cyber-input-group {
                                position: relative;
                                margin-bottom: 1.2rem;
                            }

                            .cyber-input-group label {
                                display: block;
                                color: var(--cyber-cyan);
                                font-size: 0.75rem;
                                letter-spacing: 2px;
                                text-transform: uppercase;
                                margin-bottom: 0.4rem;
                                opacity: 0.85;
                            }

                            .cyber-input {
                                width: 100%;
                                background: rgba(0, 240, 255, 0.06);
                                border: 1px solid rgba(0, 240, 255, 0.4);
                                color: var(--cyber-cyan);
                                padding: 0.75rem 1rem;
                                font-size: 1rem;
                                outline: none;
                                transition: all 0.3s;
                                font-family: 'Segoe UI', Roboto, sans-serif;
                            }

                            .cyber-input::placeholder {
                                color: rgba(0, 240, 255, 0.3);
                                font-size: 0.85rem;
                            }

                            .cyber-input:focus {
                                border-color: var(--cyber-cyan);
                                box-shadow: 0 0 12px rgba(0, 240, 255, 0.4), inset 0 0 8px rgba(0, 240, 255, 0.05);
                                background: rgba(0, 240, 255, 0.1);
                            }

                            /* 驗證錯誤狀態 */
                            .cyber-input.is-invalid {
                                border-color: var(--cyber-pink);
                                box-shadow: 0 0 8px rgba(255, 0, 60, 0.3);
                            }

                            .invalid-feedback-cyber {
                                color: var(--cyber-pink);
                                font-size: 0.72rem;
                                letter-spacing: 1px;
                                margin-top: 0.3rem;
                                text-shadow: 0 0 4px rgba(255, 0, 60, 0.5);
                            }

                            /* 輸入框 Icon */
                            .input-icon-wrap {
                                position: relative;
                            }

                            .input-icon-wrap .input-icon {
                                position: absolute;
                                right: 12px;
                                top: 50%;
                                transform: translateY(-50%);
                                color: rgba(0, 240, 255, 0.5);
                                font-size: 1rem;
                            }

                            /* 密碼強度指示器 */
                            .pwd-strength-bar {
                                height: 3px;
                                margin-top: 6px;
                                background: rgba(0, 240, 255, 0.1);
                                position: relative;
                                overflow: hidden;
                            }

                            .pwd-strength-fill {
                                height: 100%;
                                transition: width 0.4s, background 0.4s;
                                width: 0%;
                            }

                            .pwd-strength-label {
                                font-size: 0.68rem;
                                letter-spacing: 1px;
                                margin-top: 3px;
                                opacity: 0.8;
                            }

                            /* 主要提交按鈕 */
                            .btn-cyber-register {
                                width: 100%;
                                background: transparent;
                                border: 2px solid var(--cyber-cyan);
                                color: var(--cyber-cyan);
                                padding: 0.85rem;
                                font-size: 1rem;
                                font-weight: 700;
                                letter-spacing: 4px;
                                text-transform: uppercase;
                                cursor: pointer;
                                transition: all 0.3s;
                                position: relative;
                                overflow: hidden;
                                margin-top: 0.5rem;
                            }

                            .btn-cyber-register::before {
                                content: '';
                                position: absolute;
                                top: 0;
                                left: -100%;
                                width: 100%;
                                height: 100%;
                                background: linear-gradient(90deg, transparent, rgba(0, 240, 255, 0.15), transparent);
                                transition: left 0.4s;
                            }

                            .btn-cyber-register:hover::before {
                                left: 100%;
                            }

                            .btn-cyber-register:hover {
                                background: var(--cyber-cyan);
                                color: #000;
                                box-shadow: 0 0 20px var(--cyber-cyan), 0 0 40px rgba(0, 240, 255, 0.3);
                                text-shadow: none;
                            }

                            /* 重設按鈕 */
                            .btn-cyber-reset {
                                width: 100%;
                                background: transparent;
                                border: 1px solid rgba(188, 19, 254, 0.5);
                                color: var(--cyber-purple);
                                padding: 0.65rem;
                                font-size: 0.85rem;
                                letter-spacing: 2px;
                                cursor: pointer;
                                transition: all 0.3s;
                                margin-top: 0.6rem;
                            }

                            .btn-cyber-reset:hover {
                                border-color: var(--cyber-purple);
                                color: #fff;
                                box-shadow: 0 0 10px var(--cyber-purple);
                            }

                            /* 訊息區塊 */
                            .alert-cyber-success {
                                background: rgba(0, 255, 100, 0.08);
                                border: 1px solid #00ff64;
                                color: #00ff64;
                                padding: 0.8rem 1rem;
                                margin-bottom: 1.5rem;
                                font-size: 0.9rem;
                                text-align: center;
                                letter-spacing: 1px;
                                box-shadow: 0 0 10px rgba(0, 255, 100, 0.2);
                            }

                            .alert-cyber-danger {
                                background: rgba(255, 0, 60, 0.08);
                                border: 1px solid var(--cyber-pink);
                                color: var(--cyber-pink);
                                padding: 0.8rem 1rem;
                                margin-bottom: 1.5rem;
                                font-size: 0.9rem;
                                text-align: center;
                                letter-spacing: 1px;
                                box-shadow: 0 0 10px rgba(255, 0, 60, 0.2);
                            }

                            /* 底部導引連結 */
                            .register-footer-text {
                                text-align: center;
                                margin-top: 1.5rem;
                                font-size: 0.78rem;
                                color: rgba(0, 240, 255, 0.45);
                                letter-spacing: 1px;
                            }

                            .register-footer-text a {
                                color: var(--cyber-pink);
                                text-decoration: none;
                                text-shadow: 0 0 5px var(--cyber-pink);
                                transition: opacity 0.3s;
                            }

                            .register-footer-text a:hover {
                                opacity: 0.75;
                            }

                            /* 閃爍游標 */
                            @keyframes blink {

                                0%,
                                100% {
                                    opacity: 1;
                                }

                                50% {
                                    opacity: 0;
                                }
                            }

                            .cursor-blink {
                                display: inline-block;
                                animation: blink 1s step-end infinite;
                                color: var(--cyber-cyan);
                            }
                        </style>
                    </jsp:attribute>

                    <jsp:attribute name="footer_scripts">
                        <script>
                            const { createApp } = Vue;
                            createApp({
                                data() {
                                    return {
                                        password: '',
                                        errors: {
                                            password: []
                                        }
                                    };
                                },
                                computed: {
                                    pwdStrength() {
                                        const pwd = this.password;
                                        let score = 0;
                                        if (pwd.length >= 6) score++;
                                        if (pwd.length >= 10) score++;
                                        if (/[A-Z]/.test(pwd)) score++;
                                        if (/[a-z]/.test(pwd)) score++;
                                        if (/[0-9]/.test(pwd)) score++;
                                        if (/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(pwd)) score++;

                                        if (score <= 2) return { pct: 25, color: 'var(--cyber-pink)', label: '弱' };
                                        if (score <= 4) return { pct: 60, color: 'var(--cyber-purple)', label: '中' };
                                        return { pct: 100, color: '#00ff64', label: '強' };
                                    }
                                },
                                methods: {
                                    validatePassword() {
                                        this.errors.password = [];
                                        const pwd = this.password;
                                        if (pwd.length < 6 || pwd.length > 12) {
                                            this.errors.password.push('密碼長度必須在 6-12 字元之間（含）');
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
                                            this.errors.password.push('至少需要一個特殊符號（!@#$%^&* 等）');
                                        }
                                    },
                                    validateForm() {
                                        this.validatePassword();
                                        if (this.errors.password.length > 0) {
                                            Swal.fire({
                                                title: '<span style="color:var(--cyber-pink);letter-spacing:3px">驗證失敗</span>',
                                                html: '<span style="color:var(--cyber-cyan)">請修正密碼錯誤後再提交</span>',
                                                icon: 'error',
                                                background: '#0d0208',
                                                color: '#00f0ff',
                                                confirmButtonColor: '#ff003c'
                                            });
                                            return;
                                        }
                                        // 驗證通過，手動提交表單
                                        document.querySelector('form').submit();
                                    },
                                    resetForm() {
                                        this.password = '';
                                        this.errors.password = [];
                                    }
                                }
                            }).mount('#regApp');
                        </script>
                    </jsp:attribute>

                    <jsp:body>
                        <div class="register-wrapper" id="regApp">
                            <div class="register-card">

                                <%-- 標題區 --%>
                                    <div class="register-title">NEW MEMBER</div>
                                    <div class="register-subtitle">▌ 客戶資料管理系統 — 新帳戶建立 <span
                                            class="cursor-blink">_</span></div>

                                    <hr class="register-divider">

                                    <%-- Server 端訊息顯示 --%>
                                        <c:if test="${not empty msg}">
                                            <c:choose>
                                                <c:when test="${fn:contains(msg, '成功')}">
                                                    <div class="alert-cyber-success">✔ ${msg}</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="alert-cyber-danger">✘ ${msg}</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>

                                        <%-- 註冊表單 --%>
                                            <form method="post" action="${pageContext.request.contextPath}/register"
                                                @submit.prevent="validateForm">

                                                <%-- 使用者帳號 --%>
                                                    <div class="cyber-input-group">
                                                        <label for="userid">使用者帳號</label>
                                                        <div class="input-icon-wrap">
                                                            <input type="text" id="userid" name="userid"
                                                                class="cyber-input" placeholder="輸入您的帳號（英數字）..."
                                                                autocomplete="username" required />
                                                            <span class="input-icon">▶</span>
                                                        </div>
                                                    </div>

                                                    <%-- 密碼 --%>
                                                        <div class="cyber-input-group">
                                                            <label for="password">使用者密碼</label>
                                                            <div class="input-icon-wrap">
                                                                <input type="password" id="password" name="password"
                                                                    :class="['cyber-input', errors.password.length > 0 ? 'is-invalid' : '']"
                                                                    placeholder="6-12 字元，含大小寫及特殊符號..."
                                                                    autocomplete="new-password" required
                                                                    @blur="validatePassword" v-model="password" />
                                                                <span class="input-icon">◉</span>
                                                            </div>
                                                            <%-- 密碼強度指示條 --%>
                                                                <div class="pwd-strength-bar"
                                                                    v-if="password.length > 0">
                                                                    <div class="pwd-strength-fill"
                                                                        :style="{width: pwdStrength.pct + '%', background: pwdStrength.color}">
                                                                    </div>
                                                                </div>
                                                                <div class="pwd-strength-label"
                                                                    v-if="password.length > 0"
                                                                    :style="{color: pwdStrength.color}">
                                                                    強度：{{ pwdStrength.label }}
                                                                </div>
                                                                <div class="invalid-feedback-cyber"
                                                                    v-for="err in errors.password">⚠ {{ err }}</div>
                                                        </div>

                                                        <%-- 真實姓名 --%>
                                                            <div class="cyber-input-group">
                                                                <label for="realname">真實姓名</label>
                                                                <div class="input-icon-wrap">
                                                                    <input type="text" id="realname" name="realname"
                                                                        class="cyber-input" placeholder="輸入您的真實姓名..."
                                                                        required />
                                                                    <span class="input-icon">★</span>
                                                                </div>
                                                            </div>

                                                            <%-- 電子郵件 --%>
                                                                <div class="cyber-input-group">
                                                                    <label for="email">電子郵件信箱</label>
                                                                    <div class="input-icon-wrap">
                                                                        <input type="email" id="email" name="email"
                                                                            class="cyber-input"
                                                                            placeholder="example@domain.com"
                                                                            autocomplete="email" required />
                                                                        <span class="input-icon">@</span>
                                                                    </div>
                                                                </div>

                                                                <button type="submit" class="btn-cyber-register">
                                                                    ▶ 建立帳戶 / REGISTER
                                                                </button>
                                                                <button type="reset" class="btn-cyber-reset"
                                                                    @click="resetForm">
                                                                    ↺ 清除重填
                                                                </button>
                                            </form>

                                            <div class="register-footer-text">
                                                已有帳號？&nbsp;
                                                <a href="${pageContext.request.contextPath}/login">前往登入 ▶</a>
                                                &nbsp;|&nbsp; © 2026 巨匠電腦 Cyberpunk System
                                            </div>
                            </div>
                        </div>

                    </jsp:body>
                </t:base>