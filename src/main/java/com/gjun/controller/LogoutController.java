package com.gjun.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * 會員登出 Servlet 控制器
 * 負責：
 * 1. 清除前端 Cookie（.cred）
 * 2. 銷毀後端 Session
 * 3. 重新導向至登入頁面（帶登出成功訊息）
 */
@WebServlet(name = "LogoutController", urlPatterns = "/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        performLogout(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        performLogout(request, response);
    }

    /**
     * 登出核心邏輯：清除 Cookie 與 Session，重導回登入頁
     */
    private void performLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // ── 1. 清除前端 Cookie（.cred）──────────────────────
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (".cred".equals(cookie.getName())) {
                    // MaxAge 設為 0 即要求瀏覽器立即刪除此 Cookie
                    cookie.setValue("");
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    cookie.setHttpOnly(true);
                    response.addCookie(cookie);
                    System.out.println("已清除前端 Cookie：" + cookie.getName());
                }
            }
        }

        // ── 2. 銷毀後端 Session 特定的Attribute ──────────────────────────────
        HttpSession session = request.getSession(false); // false = 不新建，僅取既有(既定的Session)
        if (session != null) {
            String userName = (String) session.getAttribute(".cred");
            session.invalidate(); // 立即銷毀整個 Session
            System.out.println("已銷毀 Session，登出使用者：" + userName);
        }

        // ── 3. 導回登入頁，附帶登出成功參數 ─────────────────
        response.sendRedirect(request.getContextPath() + "/login?logout=1");
    }
}
