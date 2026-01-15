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
@WebServlet(name = "MemberRegister", urlPatterns = "/member/register")
public class MemberRegister extends HttpServlet {
    // overriding 配合Request 請求方法GET 改寫doGet
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("執行 doGet - 進入註冊頁面");
        // 互動處理 產生狀態state(簡單一個字串 也可以處理資料之後的多筆結果...) 再將狀態到頁面去
        // 調用網頁JSP頁面 借助Request 問出RequestDispatcher介面
        RequestDispatcher disp = req.getRequestDispatcher("/WEB-INF/member/register.jsp");
        // 準備一下(可能處理後有些狀態 要帶JSP去) 開始過去
        disp.forward(req, resp);// 介面多型化
        // 不要再寫了

    }

    // 沒有Overriding doPost Method，白話一點 沒有支援Request Method-POST
    public void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        // 擷取表單欄位(前提 是表單採用的編碼是???)
        // 設定配合請求編碼規則
        request.setCharacterEncoding("UTF-8");
        String userId = request.getParameter("userid");
        String password = request.getParameter("password");
        String realName = request.getParameter("realname");
        String email = request.getParameter("email");
        // 設定回應編碼規則
        resp.setContentType("text/html;charset=UTF-8");// text/plain
        // 主控台先喵一下
        System.out.println("執行 doPost - 收到註冊請求, UserId: " + userId);
        // resp.getWriter().println("<font size='6' color='red'>輸入真實性名:" + realName +
        // "<font>");
        // TODO 將會員資料儲存資料庫資料表
        // 假設會員註冊成功 產生訊息狀態 帶向View Page進行渲染
        String message = "";
        if (userId != null && !userId.trim().isEmpty()) {
            message = "[DEBUG] 您已成功註冊!!";
            System.out.println("設定成功訊息到 request attribute");
            // 持續這一個字串物件到View Page去
            request.setAttribute("msg", message);
        } else {
            System.out.println("未填寫 UserId，不設定成功訊息");
            // 如果沒有輸入資料，可以選擇不設定 msg，或設定警告
            // request.setAttribute("msg", "請輸入完整的註冊資訊");
        }

        // 調用頁面 經由request參照出相對RequestDispatcher物件 進行調用
        request.getRequestDispatcher("/WEB-INF/member/register.jsp").forward(request, resp);
    }
}
