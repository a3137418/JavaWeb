package com.gjun.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import com.gjun.model.Customers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 會員註冊 Servlet 控制器
 * 負責處理註冊頁面的請求轉發與資料存檔
 */
@WebServlet("/register")
public class RegisterController extends HttpServlet {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 將請求轉發到 JSP 頁面
        request.getRequestDispatcher("/WEB-INF/views/users/register.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 擷取表單欄位
        String account = request.getParameter("userid");
        String password = request.getParameter("password");
        String realName = request.getParameter("realname");
        String email = request.getParameter("email");

        String message = "";

        // 1. 檢查帳號是否存在
        String checkSql = "Select UserName, Password, RealName, Email from OnlineUsers where UserName = ?";
        try {
            jdbcTemplate.queryForObject(checkSql, (rs, rowNum) -> {
                Customers c = new Customers();
                c.setUserName(rs.getString("UserName"));
                return c;
            }, account);

            // 如果沒拋出例外，代表找到了
            message = String.format("帳號 [%s] 已被註冊，請換一個！", account);
        } catch (DataAccessException e) {
            // 2. 找不到帳號，進行註冊
            String insertSql = "Insert Into OnlineUsers(UserName, Password, RealName, Email) values(?,?,?,?)";
            try {
                jdbcTemplate.update(insertSql, account, password, realName, email);
                message = "恭喜您，註冊成功！";
            } catch (DataAccessException ex) {
                message = "註冊時發生資料庫錯誤：" + ex.getMessage();
            }
        }

        // 將訊息帶回頁面
        request.setAttribute("msg", message);
        request.getRequestDispatcher("/WEB-INF/views/users/register.jsp").forward(request, response);
    }
}