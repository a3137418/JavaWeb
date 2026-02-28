<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>

            <t:base pageTitle="首頁入口">
                <jsp:body>
                    <div class="cyber-card text-center">
                        <h1 class="display-3 glitch-text">歡迎進入</h1>
                        <h2 class="text-pink">客戶資料管理系統</h2>
                        <p class="lead mt-4" style="color: var(--cyber-cyan);">
                            這是一個基於 Spring Boot 與 JSP 技術開發的企業級管理系統。<br>
                            採用賽博龐克視覺設計，提供更極致的視覺體驗。
                        </p>

                        <hr class="my-5" style="border-color: var(--cyber-pink); opacity: 0.5;">

                        <div class="row mt-4">
                            <div class="col-md-6 mb-3">
                                <div class="p-4 border border-cyan">
                                    <h3 class="h4">傳統查詢</h3>
                                    <p>使用標準 JSP 與資料庫整合的查詢方式。</p>
                                    <a href="${pageContext.request.contextPath}/customers"
                                        class="btn btn-outline-info w-100">進入查詢</a>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <div class="p-4 border border-pink">
                                    <h3 class="h4">SPA 應用</h3>
                                    <p>體驗無縫跳轉的單頁式應用程序介面。</p>
                                    <a href="${pageContext.request.contextPath}/spa"
                                        class="btn btn-outline-danger w-100">體驗 SPA</a>
                                </div>
                            </div>
                        </div>

                        <div class="mt-5 text-muted small">
                            <p>核心引擎已啟動 | 狀態：<span class="text-success">運作中</span></p>
                        </div>
                    </div>

                    <style>
                        .border-cyan {
                            border-color: var(--cyber-cyan) !important;
                            color: var(--cyber-cyan);
                        }

                        .border-pink {
                            border-color: var(--cyber-pink) !important;
                            color: var(--cyber-pink);
                        }

                        .text-pink {
                            color: var(--cyber-pink);
                            text-shadow: 0 0 10px var(--cyber-pink);
                        }
                    </style>

                    <script>
                        const { createApp } = Vue;
                        createApp({
                            data() {
                                return {
                                    status: 'ONLINE'
                                }
                            },
                            mounted() {
                                console.log("Cyberpunk Interface initialized.");
                            }
                        }).mount('#app');
                    </script>
                </jsp:body>
            </t:base>