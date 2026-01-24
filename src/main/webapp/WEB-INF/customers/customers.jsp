<!-- JSP page Directive -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>客戶資料維護</title>
    </head>

    <body>
        <!-- 查詢結果資料渲染 -->
        <div>
            <h3>客戶資料清單</h3>
            <!-- JSP Exoression Language -->
            <h4>客戶資料數:${customers.size()}</h4>
            <h4>
                <%=((List<MyCustomers>)request.getAttribute("customers")).size() %>
            </h4>
        </div>
    </body>

    </html>