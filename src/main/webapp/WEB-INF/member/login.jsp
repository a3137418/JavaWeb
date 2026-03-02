<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

                <t:base pageTitle="會員登入">
                    <jsp:attribute name="head_scripts">
                        <style>
                            /* ===== 登入頁面專屬樣式 ===== */
                            .login-wrapper {
                                min-height: 80vh;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                            }

                            .login-card {
                                background: rgba(13, 2, 8, 0.92);
                                border: 1px solid var(--cyber-cyan);
                                box-shadow: 0 0 30px rgba(0, 240, 255, 0.2), 5px 5px 0px var(--cyber-pink);
                                padding: 3rem 2.5rem;
                                width: 100%;
                                max-width: 460px;
                                position: relative;
                                overflow: hidden;
                            }

                            /* 裝飾性頂部橫條 */
                            .login-card::before {
                                content: '';
                                position: absolute;
                                top: 0;
                                left: 0;
                                right: 0;
                                height: 4px;
                                background: linear-gradient(90deg, var(--cyber-pink), var(--cyber-cyan), var(--cyber-purple));
                            }

                            /* 背景掃描線動畫 */
                            .login-card::after {
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

                            .login-title {
                                font-size: 1.8rem;
                                font-weight: 700;
                                color: var(--cyber-cyan);
                                text-shadow: 0 0 12px var(--cyber-cyan);
                                text-align: center;
                                letter-spacing: 4px;
                                text-transform: uppercase;
                                margin-bottom: 0.3rem;
                            }

                            .login-subtitle {
                                text-align: center;
                                color: var(--cyber-purple);
                                font-size: 0.8rem;
                                letter-spacing: 2px;
                                margin-bottom: 2rem;
                                opacity: 0.8;
                            }

                            .login-divider {
                                border: none;
                                border-top: 1px solid var(--cyber-pink);
                                opacity: 0.4;
                                margin: 1.5rem 0;
                            }

                            /* 輸入框樣式 */
                            .cyber-input-group {
                                position: relative;
                                margin-bottom: 1.5rem;
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

                            /* 輸入框 Icon 前綴 */
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

                            /* 登入按鈕 */
                            .btn-cyber-login {
                                width: 100%;
                                background: transparent;
                                border: 2px solid var(--cyber-pink);
                                color: var(--cyber-pink);
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

                            .btn-cyber-login::before {
                                content: '';
                                position: absolute;
                                top: 0;
                                left: -100%;
                                width: 100%;
                                height: 100%;
                                background: linear-gradient(90deg, transparent, rgba(255, 0, 60, 0.15), transparent);
                                transition: left 0.4s;
                            }

                            .btn-cyber-login:hover::before {
                                left: 100%;
                            }

                            .btn-cyber-login:hover {
                                background: var(--cyber-pink);
                                color: #fff;
                                box-shadow: 0 0 20px var(--cyber-pink), 0 0 40px rgba(255, 0, 60, 0.3);
                                text-shadow: 0 0 8px #fff;
                            }

                            /* 取消/重設按鈕 */
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

                            /* 底部連結文字 */
                            .login-footer-text {
                                text-align: center;
                                margin-top: 1.5rem;
                                font-size: 0.78rem;
                                color: rgba(0, 240, 255, 0.45);
                                letter-spacing: 1px;
                            }

                            /* 閃爍游標動畫 */
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
                                color: var(--cyber-pink);
                            }
                        </style>
                    </jsp:attribute>

                    <jsp:body>
                        <div class="login-wrapper">
                            <div class="login-card">

                                <%-- 標題區 --%>
                                    <div class="login-title">SYSTEM LOGIN</div>
                                    <div class="login-subtitle">▌ 客戶資料管理系統 — 身份驗證中樞 <span class="cursor-blink">_</span>
                                    </div>

                                    <hr class="login-divider">

                                    <%-- 訊息顯示區 --%>
                                        <%-- 優先判斷登出成功參數 --%>
                                            <c:choose>
                                                <c:when test="${param.logout eq '1'}">
                                                    <div class="alert-cyber-success">✔ 您已安全登出系統，感謝使用！</div>
                                                </c:when>
                                                <c:when test="${not empty message}">
                                                    <c:choose>
                                                        <c:when test="${fn:contains(message, '成功')}">
                                                            <div class="alert-cyber-success">✔ ${message}</div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="alert-cyber-danger">✘ ${message}</div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                            </c:choose>

                                            <%-- 登入表單 --%>
                                                <form method="post" action="${pageContext.request.contextPath}/login">
                                                    <div class="cyber-input-group">
                                                        <label for="username">使用者帳號</label>
                                                        <div class="input-icon-wrap">
                                                            <input type="text" id="username" name="username"
                                                                class="cyber-input" placeholder="輸入您的帳號..."
                                                                autocomplete="username" required />
                                                            <span class="input-icon">▶</span>
                                                        </div>
                                                    </div>

                                                    <div class="cyber-input-group">
                                                        <label for="password">使用者密碼</label>
                                                        <div class="input-icon-wrap">
                                                            <input type="password" id="password" name="password"
                                                                class="cyber-input" placeholder="輸入您的密碼..."
                                                                autocomplete="current-password" required />
                                                            <span class="input-icon">◉</span>
                                                        </div>
                                                    </div>

                                                    <button type="submit" class="btn-cyber-login">
                                                        ▶ 身份驗證 / LOGIN
                                                    </button>
                                                    <button type="reset" class="btn-cyber-reset">
                                                        ↺ 清除重填
                                                    </button>
                                                </form>

                                                <div class="login-footer-text">
                                                    © 2026 巨匠電腦 Cyberpunk System &nbsp;|&nbsp; Secured Access Only
                                                </div>
                            </div>
                        </div>
                    </jsp:body>
                </t:base>