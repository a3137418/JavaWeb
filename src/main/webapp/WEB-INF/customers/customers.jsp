<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.gjun.model.MyCustomers,java.util.List" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>客戶資料維護</title>
    </head>
    <!-- 宣告式 class level定義Data or Method 類別定義層級-->
    <%! 
    private String address="台北市公園路" ;
    public String helloWorld(){ return "大家好" ; } 
    %>
        <!-- 穿插Scriptlet _jspService方法程序-->
        <% 
        String title="Customers客戶資料清單" ;
        String author="by Eric Chen" ; 
        //取出Request參照List集合物件
        List<MyCustomers> data = (List<MyCustomers>)request.getAttribute("customers");
        %>

            <body>
                <!-- 查詢結果資料渲染 -->
                <div>
                    <!-- Scriplet expression 不能使用分號結束-->
                    <h3>
                        <%=title%>
                    </h3>
                    <h3>
                        <%=this.helloWorld()%>
                    </h3>
                    <!-- JSP Exoression Language -->
                    <h4>客戶資料數:${customers.size()}</h4>
                    <h4>
                    </h4>
                </div>
                <!-- 呈現多筆多欄結果List<Mycustomers> -->
                <div>
                    <table>
                        <thead>
                            <tr>
                                <th>客戶編號</th>
                                <th>公司行號</th>
                                <th>聯絡地址</th>
                                <th>連絡電話</th>
                                <th>國家別</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- 採用for each Java -->
                             <% for (MyCustomers customer : data) {
                                //進入網頁層級的Attribute pageContext JSP內建物件 就是PageContext Instance
                                pageContext.setAttribute("customer",customer);
                                 %>
                            <tr>
                                <!-- EL 操作物件的Property getXxxx-->
                                <td>${customer.customerID}</td>
                                <td><%=customer.getCompanyName()%></td>
                                <td><%=customer.getAddress()%></td>
                                <td><%=customer.getPhone()%></td>
                                <td><%=customer.getCountry()%></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
            </body>

    </html>