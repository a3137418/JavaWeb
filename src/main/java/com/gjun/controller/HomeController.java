package com.gjun.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 繼承 HttpServlet 抽象類別
 * 使用 Annotation 進行 Servlet 佈署到 Web Container
 * loadOnStartup=1 這一個Servlet跟著應用系統啟動 同時產生個體物件
 * loadOnStartup沒有下 這一個Servlet必須配合前端第一次請求 才會產生個體物件
 * 定義訪問路徑為 /home
 */
@WebServlet(urlPatterns = { "/home" })
public class HomeController extends HttpServlet {

    @Override
    public void init() {
        // 隨機碼
        double random = (int) (Math.random() * 1000);
        System.out.println("HomeController 初始化成功..." + random);
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 設定回應的內容類型與編碼 (繁體中文呈現)
        resp.setContentType("text/html;charset=UTF-8");

        // 2. 取得輸出物件
        try (PrintWriter out = resp.getWriter()) {
            // 3. 輸出結構化的 HTML
            // out.println("<!DOCTYPE html>");
            // out.println("<html>");
            // out.println("<head><title>首頁 - 客戶資料服務系統</title></head>");
            // out.println("<body style='font-family: Arial; text-align: center; margin-top:
            // 50px;'>");
            // out.println("<h1 style='color: #2c3e50;'>歡迎來到巨匠客戶資料服務系統</h1>");
            // out.println("<p style='color: #7f8c8d; font-size: 1.2em;'>HttpServletRequest
            // 已成功解析，服務運作中。</p>");
            // out.println("<hr style='width: 50%;'>");
            // out.println("<p>目前時間：" + new java.util.Date() + "</p>");
            // out.println("</body>");
            // out.println("</html>");

            out.println("您好，HELLO");
        }
    }

    // Overriding 聆聽這一個Servlet物件被釋放時引發事件程序
    public void destroy() {
        // Log file監測
        System.out.println("HomeController 釋放成功...");
    }
}
