package com.gjun.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CustomerClientController
 * 提供客戶端簡單提示字串的控制器 (Servlet MVC)
 */
@WebServlet("/customers/main")
public class CustomerClientController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 設定簡單提示字串
        String message = "Hello World! 歡迎來到客戶端管理系統。";

        // 2. 傳遞到 Request Scope
        request.setAttribute("helloMessage", message);

        // 3. 轉向至 JSP 視圖 (WEB-INF 下以加強安全性)
        request.getRequestDispatcher("/WEB-INF/views/customers/index.jsp").forward(request, response);
    }
}