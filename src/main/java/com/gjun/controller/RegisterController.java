package com.gjun.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 會員註冊 Servlet 控制器
 * 負責處理註冊頁面的請求轉發
 */
@WebServlet("/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 將請求轉發到 JSP 頁面
        // 路徑對應到 webapp/WEB-INF/views/users/register.jsp
        request.getRequestDispatcher("/WEB-INF/views/users/register.jsp")
                .forward(request, response);
    }
}