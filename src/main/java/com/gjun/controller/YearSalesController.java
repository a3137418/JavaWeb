package com.gjun.controller;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.gjun.repository.YearSalesRepository;
import com.gjun.model.YearSales;
import java.util.List;

//設計HttpServlet 當作MVC(Controller控制器)
//借助Annotation描述端點與佈署
@WebServlet("/sales/year")
public class YearSalesController extends HttpServlet {
    // Overriding doGet Method
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 實作 GET 請求處理邏輯 調用查詢頁面JSP 採用Model2(MVC) Dispatcher Page
        request.getRequestDispatcher("/WEB-INF/sales/yearsales.jsp").forward(request, response);
    }

    // Overriding doPost Method 處理表單提交
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. 取得請求參數(配合form field name attribute)
        String yearStr = request.getParameter("year");
        // 邏輯驗證
        if (yearStr != null && !yearStr.isEmpty()) {
            try {
                // 進行轉換Wrapper Class Integer
                Integer year = Integer.parseInt(yearStr);

                // 2. 從 Spring Context 中取得 Repository Bean
                // 因為 HttpServlet 不是由 Spring Container 直接 Autowired 的，需手動查找
                // 透過HttpServlet問出網站應用系統(ServletContext介面)
                ServletContext servletContext = getServletContext();
                // 將HttpServet界接在Spring Application架構上
                WebApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(servletContext);
                YearSalesRepository repository = context.getBean(YearSalesRepository.class); // Meta class

                // 3. 呼叫 Repository 執行查詢
                List<YearSales> salesList = repository.findByYear(year);

                // 4. 將結果存入 Request Attribute 傳給 View (JSP)
                request.setAttribute("salesList", salesList);

                System.out.println("銷售資料記錄數:" + salesList.size());
                request.setAttribute("selectedYear", year);

            } catch (NumberFormatException e) {
                request.setAttribute("error", "請輸入有效的年份格式");
            } catch (Exception e) {
                request.setAttribute("error", "查詢時發生錯誤: " + e.getMessage());
            }
        } else {
            request.setAttribute("message", "請輸入查詢年份");
        }

        // 5. 轉導回 JSP 顯示結果
        request.getRequestDispatcher("/WEB-INF/sales/yearsales.jsp").forward(request, response);
    }

}