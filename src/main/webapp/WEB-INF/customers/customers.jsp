<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
        <%@ taglib prefix="c" uri="jakarta.tags.core" %>
            <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

                <t:base pageTitle="客戶資料維護">
                    <jsp:body>
                        <div class="card shadow">
                            <div class="card-header bg-primary text-white">
                                <h3 class="mb-0">Customers客戶資料清單</h3>
                            </div>
                            <div class="card-body">
                                <div class="mb-4 text-secondary">
                                    <h6>客戶資料數：${fn:length(customers)}</h6>
                                </div>

                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped table-hover mt-3">
                                        <thead class="table-dark">
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
                                            <c:forEach var="customer" items="${customers}">
                                                <tr>
                                                    <td>${customer.customerID}</td>
                                                    <td>${customer.companyName}</td>
                                                    <td>${customer.address}</td>
                                                    <td>${customer.phone}</td>
                                                    <td>${customer.country}</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-warning">編輯</button>
                                                        <button class="btn btn-sm btn-danger">刪除</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <script>
                            const { createApp } = Vue;
                            createApp({
                                data() {
                                    return {}
                                }
                            }).mount('#app');
                        </script>
                    </jsp:body>
                </t:base>