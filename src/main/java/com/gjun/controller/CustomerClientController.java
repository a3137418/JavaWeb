package com.gjun.controller;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * CustomerClientController
 * 提供簡單的 Hello World 提示
 */
@WebServlet(name = "CustomerClientController", urlPatterns = "/customers/main")
public class CustomerClientController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 設定簡單的 Hello World 字串提示
        String message = "Hello World! 這是來自 CustomerClientController 的訊息。";
        request.setAttribute("message", message);

        // 調派至 WEB-INF/views/users/customers/index.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/users/customers/index.jsp");
        dispatcher.forward(request, response);
    }
}
