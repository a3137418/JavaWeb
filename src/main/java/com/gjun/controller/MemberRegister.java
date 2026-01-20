package com.gjun.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import com.gjun.model.Customers;

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
    // Data Field(Attribute)透過web Container注入物件
    // Data field 注入依賴物件(軟體工程稱為DI Field Injection)
    @Autowired
    private JdbcTemplate jdbcTemplate;// 採用資料型別JdbcTemplate 去Web Container找一下註冊起來的Bean

    // overriding 配合Request 請求方法GET 改寫doGet
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("JdbcTemplate物件:" + this.jdbcTemplate);

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
        // 將會員資料儲存資料庫資料表
        // 1.借助使用UserId進行查詢 是否存在 如果存在 會員識別碼重複了...(無須進行新增作業)
        // 查詢敘述 帶參數架構
        String message = null;
        String sql = "Select UserName,Password,RealName,Email from OnlineUsers where UserName=?";
        // 進行例外管理 找不到
        try {
            Customers cust = this.jdbcTemplate.queryForObject(sql,
                    // Lambda Expression 配合RowMapper interface 唯一抽象方法架構mapRow(resultset.rownumber)
                    (rs, number) -> {
                        // 封裝成JavaBean
                        Customers customers = new Customers();
                        // 屬性注入查詢結果
                        customers.setUserName(rs.getString("UserName"));
                        customers.setPassword(rs.getString("Password"));
                        customers.setRealName(rs.getString("RealName"));
                        customers.setEmail(rs.getString("Email"));
                        return customers;
                    },
                    // 傳遞查詢參數
                    userId);
            // 提醒使用者不能新增 帶回狀態
            System.out.println("找到既定的會員名稱..." + cust.getRealName());
            message = String.format("使用者名稱:%s 已經被註冊了!!請重新輸入!!", userId);
        } catch (DataAccessException ex) {
            // 找不到 反而進行會員新增註冊
            System.out.println("找不到既定的會員名稱...");
            // TODO 假設會員註冊成功 產生訊息狀態 帶向View Page去
            String insertSQL = "Insert Into OnlineUsers(UserName,Password,RealName,Email) values(?,?,?,?)";
            try {
                int counter = this.jdbcTemplate.update(insertSQL, userId, password, realName, email);
            } catch (DataAccessException e) {
                message = "會員註冊產生儲存例外!!!";
            }

            message = "註冊成功了";

        }
        // 持續這一個字串物件到View Page去
        request.setAttribute("msg", message);
        // 調用頁面 經由request參照出相對RequestDispatcher物件 進行調用
        request.getRequestDispatcher("/WEB-INF/member/register.jsp").forward(request, resp);
    }
}
