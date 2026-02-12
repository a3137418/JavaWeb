---
name: servlet-mvc
description: Servlet MVC 控制器開發規範與範本。
---

# Servlet MVC 控制器實作規範

定義傳統 Java EE / Jakarta EE Servlet 作為 MVC 架構中 Controller 的開發流程。

## 實作程序

1. **繼承 HttpServlet**: 建立 Java 類別並繼承 `HttpServlet`。
2. **註解配置**: 使用 `@WebServlet` 定義 URL 映射。
3. **實作請求處理方法**: 覆寫 `doGet` 或 `doPost`。
4. **獲取參數**: 使用 `request.getParameter()` 讀取用戶輸入。
5. **商業邏輯調用**: 呼叫對應的 Service 處理業務。
6. **視圖轉向**: 使用 `RequestDispatcher` 將請求轉發至 JSP。

## 代碼範本

```java
package com.example.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/example")
public class ExampleController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 獲取參數
        String name = request.getParameter("name");
        
        // 2. 商業邏輯運算 (範例)
        String message = "Hello, " + (name != null ? name : "Guest");
        
        // 3. 傳遞實體資料到 Request Scope
        request.setAttribute("msg", message);
        
        // 4. 轉向 JSP 視圖
        request.getRequestDispatcher("/WEB-INF/views/result.jsp").forward(request, response);
    }
}
```

## 注意事項
- Controller 應保持輕量，僅負責請求分發。
- 具體業務邏輯應封裝在 Service 層。
- 視圖頁面通常放在 `WEB-INF` 下以防止使用者直接存取。
