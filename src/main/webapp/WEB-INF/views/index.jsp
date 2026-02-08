<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

            <t:base pageTitle="JSP 樣板測試">
                <jsp:attribute name="head_scripts">
                    <style>
                        .card-hero {
                            background: white;
                            padding: 2rem;
                            border-radius: 12px;
                            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                            text-align: center;
                            margin-top: 2rem;
                        }

                        h1 {
                            color: #1a73e8;
                        }

                        .message {
                            font-size: 1.2rem;
                            color: #5f6368;
                        }

                        .footer {
                            margin-top: 2rem;
                            font-size: 0.8rem;
                            color: #9aa0a6;
                        }
                    </style>
                </jsp:attribute>

                <jsp:body>
                    <div class="card card-hero">
                        <h1>JSP 樣板引擎正常運作！</h1>
                        <!--使用JSP EL運算變數-->
                        <p class="message">${message}</p>
                        <div class="footer">
                            <p>目前時間：<%= new java.util.Date() %>
                            </p>
                            <p>Spring Boot + JSP + JSTL (Jakarta EE)</p>
                        </div>
                    </div>
                    <div class="mt-4">
                        <!-- 使用core JSTL out 標籤 -->
                        <h3>
                            <c:out value="您好，世界和平" />
                            <br />
                            <c:out value="${message}" />
                        </h3>
                    </div>
                </jsp:body>
            </t:base>