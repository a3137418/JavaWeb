<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="com.gjun.model.MyCustomers,java.util.List" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>

            <t:base pageTitle="客戶資料維護">
                <jsp:body>
                    <div class="card shadow mb-4">
                        <div class="card-header bg-info text-white">
                            <h4 class="mb-0">Customers 客戶資料清單</h4>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <span class="badge bg-secondary">作者：by Eric Chen</span>
                                <span class="badge bg-primary">客戶資料數：${customers.size()}</span>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover table-striped table-bordered">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>客戶編號</th>
                                            <th>公司行號</th>
                                            <th>聯絡地址</th>
                                            <th>連絡電話</th>
                                            <th>國家別</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="customer" items="${customers}">
                                            <tr>
                                                <td>${customer.customerID}</td>
                                                <td>${customer.companyName}</td>
                                                <td>${customer.address}</td>
                                                <td>${customer.phone}</td>
                                                <td>${customer.country}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </jsp:body>
            </t:base>