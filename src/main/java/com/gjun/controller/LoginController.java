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

//HttpServlet 實作登入作業
//進行佈署與描述
@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {
    // Data field 注入依賴物件 Repositroy
    @Autowired
    private UserRepository repository;

    // Overriding doGet Method
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse resp) throws IOException, ServletException {
        // 調用View Page(登入頁面)借助Request參照出RequsetDispatcher
        RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/member/login.jsp");
        // 交付到頁面去 持續這裡Request and Response生命週期
        disp.forward(request, resp);
    }

    // Overiding doPost
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse resp) throws IOException, ServletException {
        // 設定Request編碼規則(可以順利擷取到中文編碼)
        request.setCharacterEncoding("UTF-8");
        // 擷取表單欄位(帳號密碼)
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.printf("使用者帳號:%s 密碼:%s", userName, password); // printf() format
        // 進入會員資料驗證流程，呼叫注入依賴的物件UsersRepository
        OnLineUsers users = this.repository.findById(userName + "," + password);
        String viewPage = null;
        // 判斷是否有查詢到
        if (users != null) {
            // 登入驗證成功
            System.out.println("登入驗證成功");
            // 建立一個Cookie物件，帶到瀏覽器去
            Cookie cookie = new Cookie(".cred", userName);
            // 讓Response進行參考
            resp.addCookie(cookie);
            // 透過Request問出一個既定或者新的Session 進行狀態管理(後端有一個登入成功的憑證)
            HttpSession session = request.getSession(true);// Session是一個袋子(Collection集合)
            session.setAttribute(".cred", userName);
            // 生命週期預設多久(Slider time)
            int min = session.getMaxInactiveInterval() / 60;
            System.out.println("Session預設最大的終止時間:" + min);
            // 設定訊息狀態，到頁面渲染
            request.setAttribute("message", "登入驗證成功!!");
            // 設定調用的頁面
            viewPage = "/WEB-INF/member/login.jsp";
        } else {
            // 登入驗證失敗
            System.out.println("登入驗證失敗");
            // 設定訊息狀態，到頁面渲染
            request.setAttribute("message", "登入驗證失敗!!");
            // 設定調用的頁面
            viewPage = "/WEB-INF/member/login.jsp";
        }
        // 派送頁面
        request.getRequestDispatcher(viewPage).forward(request, resp);

    }

}
