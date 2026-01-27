package com.gjun.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.gjun.model.MyCustomers;
import com.gjun.repository.CustomersCRUDRepository;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//自訂HttpServlet 進行佈署 與描述(才有端點end Point) 使用Annnotation
@WebServlet(name = "CustomersController", urlPatterns = "/customers/all")
public class CustomersController extends HttpServlet {
    // Data Field 注入Repository
    @Autowired
    private CustomersCRUDRepository respo;

    @Override
    public void init() throws ServletException {
        org.springframework.web.context.support.SpringBeanAutowiringSupport.processInjectionBasedOnCurrentContext(this);
    }

    // Overriding doGet 採用Http Request Method-GET 進入點
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        // 進行客戶資料所有資料查詢作業
        List<MyCustomers> data = respo.all();// 呼叫注入進來的Repositoory all() Method
        // 調用網頁JSP 借助RequestDispatcher 進行調派
        RequestDispatcher disp = request.getRequestDispatcher("/WEB-INF/customers/customers.jsp");
        // 有些狀態管理要進行 查詢結果
        request.setAttribute("customers", data);
        disp.forward(request, resp);

    }

}