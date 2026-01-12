package com.gjun.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//繼承HttpServlet(提供註冊作業)
//部屬與描述對外端點 name attribute定義Servlet內部名稱(具有唯一性)
@WebServlet
public class MemberRegister extends HttpServlet {
    // overriding 配合Request 請求方法GET 改寫doGet
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 互動處理 產生狀態 再將狀態到頁面去
        // 調用網頁JSP頁面 借助Request 問出RequestDispatcher介面
        RequestDispatcher disp = req.getRequestDispatcher("/WEB-INF/member/register.jsp");
        // 準備一下(可能處理後有些狀態 要帶JSP去) 開始過去
        disp.forward(req, resp);// 介面多型化
        // 不要再寫了
    }
}
