package com.gjun.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;

import com.gjun.model.OnLineUsers;
import com.gjun.repository.UserRepository;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "Logincontroller2", urlPatterns = "/login2")
public class Logincontroller2 extends HttpServlet {
    @Autowired
    private UserRepository repository;

    public void doGet(HttpServletRequest request, HttpServletResponse resp) throws IOException, ServletException {
        RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/member/login2.jsp");
        disp.forward(request, resp);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse resp) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.printf("使用者帳號:%s 密碼:%s", username, password);

        OnLineUsers users = this.repository.findById(username + "," + password);
        String viewPage = null;

        // 判斷
        if (users != null) {
            System.out.println("登入驗證成功");

            Cookie cookie = new Cookie(".cred", username);
            cookie.setHttpOnly(true);
            cookie.setSecure(true);
            cookie.setAttribute("SameSite", "Lax");
            resp.addCookie(cookie);

            HttpSession session = request.getSession(true);
            session.setAttribute(".cred", username);
            int min = session.getMaxInactiveInterval() / 60;
            System.out.println("Session預設最大的終止時間:" + min);

            request.setAttribute("message", "登入驗證成功!!");
            request.setAttribute("status", "success");

            viewPage = "/WEB-INF/member/login2.jsp";
        } else {
            System.out.println("登入驗證失敗");
            request.setAttribute("message", "登入驗證失敗!!");
            request.setAttribute("status", "error");
            viewPage = "/WEB-INF/member/login2.jsp";
        }
        // 派送頁面
        request.getRequestDispatcher(viewPage).forward(request, resp);

    }

}
