package com.gjun.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 使用 Servlet 實作的 HelloController
 * 端點為 /hello
 */
@WebServlet(urlPatterns = { "/hello" })
public class HelloController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 設定傳遞給 JSP 的訊息
        req.setAttribute("message", "這是一個透過 HttpServlet (HelloController) 端點 /hello 轉發的 JSP 頁面。");

        // 使用 RequestDispatcher 轉發到 index.jsp
        // 注意：由於 application.properties 的視圖解析器僅適用於 Spring MVC，
        // 在 Servlet 中必須指定完整路徑 /WEB-INF/views/index.jsp
        req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, resp);
    }
}