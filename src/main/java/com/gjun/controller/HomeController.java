package com.gjun.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 處理網站入口請求
 * 定義訪問路徑為 / 或 /home
 */
@WebServlet(urlPatterns = { "/home" })
public class HomeController extends HttpServlet {

    @Override
    public void init() {
        System.out.println("HomeController (Cyberpunk Edition) 初始化成功...");
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 設定屬性傳遞給 JSP
        req.setAttribute("message", "系統核心已解鎖，歡迎訪問。");

        // 轉發至 JSP 頁面
        req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, resp);
    }

    @Override
    public void destroy() {
        System.out.println("HomeController 釋放成功...");
    }
}