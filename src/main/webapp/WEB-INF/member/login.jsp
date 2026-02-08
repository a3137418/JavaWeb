<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

        <t:base pageTitle="會員登入">
            <jsp:body>
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card shadow">
                            <div class="card-header bg-primary text-white text-center">
                                <h4 class="mb-0">會員登入</h4>
                            </div>
                            <div class="card-body p-4">
                                <form method="post">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">使用者帳號</label>
                                        <input type="text" class="form-control" id="username" name="username" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="password" class="form-label">使用者密碼</label>
                                        <input type="password" class="form-control" id="password" name="password"
                                            required>
                                    </div>
                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary">登入</button>
                                        <button type="reset" class="btn btn-outline-secondary">取消</button>
                                    </div>
                                </form>

                                <c:if test="${not empty message}">
                                    <div class="alert alert-warning mt-3">
                                        ${message}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </jsp:body>
        </t:base>