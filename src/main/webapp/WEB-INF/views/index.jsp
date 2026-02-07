<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>



    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>JSP 樣板測試</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                background-color: #f0f2f5;
            }

            .card {
                background: white;
                padding: 2rem;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                text-align: center;
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
    </head>

    <body>
        <div class="card">
            <h1>JSP 樣板引擎正常運作！</h1>
            <!--使用JSP EL運算變數-->
            <p class="message">${message}</p>
            <div class="footer">
                <p>目前時間：<%= new java.util.Date() %>
                </p>
                <p>Spring Boot + JSP + JSTL (Jakarta EE)</p>
            </div>
        </div>
        <div>
            <!-- 使用core JSTL out 標籤相對於 -->
            <h3>
                <c:out value="您好，世界和平"/>
                <br/>
                <c:out value="${message}"/>
            </h3>
            <h3>
                
            </h3>
        </div>
    </body>

    </html>