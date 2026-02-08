<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

                <t:base pageTitle="年度產品銷售分析">
                    <jsp:body>
                        <div class="card shadow">
                            <div class="card-header bg-primary text-white">
                                <h3 class="mb-0">年度產品銷售分析</h3>
                            </div>
                            <div class="card-body">
                                <!--表單頁面-->
                                <form method="post" class="row g-3 align-items-center mb-4">
                                    <div class="col-auto">
                                        <label class="form-label fw-bold">業務年度</label>
                                    </div>
                                    <div class="col-auto">
                                        <input type="number" name="year" class="form-control" value="${selectedYear}"
                                            placeholder="例如: 1997" required />
                                    </div>
                                    <div class="col-auto">
                                        <button type="submit" class="btn btn-success">查詢分析</button>
                                    </div>
                                </form>

                                <hr>

                                <!-- 錯誤訊息 -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>
                                <c:if test="${not empty message}">
                                    <div class="alert alert-info">${message}</div>
                                </c:if>

                                <!-- 查詢結果列表 -->
                                <c:if test="${not empty salesList}">
                                    <h4 class="mb-3 text-secondary">${selectedYear} 年度銷售統計結果</h4>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped table-hover mt-3">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th>年度</th>
                                                    <th>產品 ID</th>
                                                    <th>產品名稱</th>
                                                    <th>總銷售金額 (USD)</th>
                                                    <th>總銷售數量</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="sale" items="${salesList}">
                                                    <tr>
                                                        <td>${sale.getYear()}</td>
                                                        <!-- Property -->
                                                        <td>${sale.productID}</td>
                                                        <td>${sale.productName}</td>
                                                        <td class="text-end fw-bold">
                                                            <fmt:formatNumber value="${sale.totalAmt}" type="currency"
                                                                currencySymbol="$" />
                                                        </td>
                                                        <td class="text-center">${sale.totalQty}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <script>
                            const { createApp } = Vue;
                            createApp({
                                data() {
                                    return {
                                        // 如果未來需要 Vue 綁定可以在此擴充
                                    }
                                }
                            }).mount('#app');
                        </script>
                    </jsp:body>
                </t:base>