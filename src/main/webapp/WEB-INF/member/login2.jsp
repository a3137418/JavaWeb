<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

            <t:base pageTitle="會員登入 v2">
                <jsp:attribute name="footer_scripts">
                    <c:if test="${not empty message}">
                        <script>
                            // 如果後端有傳回錯誤訊息，使用 SweetAlert2 顯示
                            Swal.fire({
                                icon: '${status == "success" ? "success" : "error"}',
                                title: '${status == "success" ? "登入成功" : "登入失敗"}',
                                text: '${message}',
                                background: '#1a1a1a',
                                color: '${status == "success" ? "#00ff00" : "#00f0ff"}',
                                confirmButtonColor: '${status == "success" ? "#00ff00" : "#ff003c"}'
                            });
                        </script>
                    </c:if>
                </jsp:attribute>

                <jsp:body>
                    <div class="row justify-content-center">
                        <div class="col-md-5">
                            <div class="cyber-card">
                                <h2 class="text-center mb-4 glitch-text" data-text="MEMBER LOGIN">MEMBER LOGIN</h2>

                                <form action="${pageContext.request.contextPath}/login2" method="post">
                                    <div class="mb-4">
                                        <label for="username" class="form-label text-info">使用者帳號</label>
                                        <input type="text" class="form-control bg-dark text-white border-info"
                                            id="username" name="username" placeholder="請輸入帳號" required>
                                    </div>

                                    <div class="mb-4">
                                        <label for="password" class="form-label text-info">使用者密碼</label>
                                        <input type="password" class="form-control bg-dark text-white border-info"
                                            id="password" name="password" placeholder="請輸入密碼" required>
                                    </div>

                                    <div class="d-grid gap-3">
                                        <button type="submit" class="btn btn-outline-info border-2 fw-bold">
                                            登入
                                        </button>
                                        <button type="reset" class="btn btn-outline-secondary btn-sm">
                                            重新輸入
                                        </button>
                                    </div>
                                </form>

                                <c:if test="${not empty message}">
                                    <div
                                        class="mt-4 p-2 border ${status == 'success' ? 'border-success text-success' : 'border-danger text-danger'} text-center bg-dark">
                                        ${message}
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </jsp:body>
            </t:base>