<!--JSP Directive 指示詞-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="zh-TW">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>會員註冊 - MyWeb</title>
        <!-- 引用專案中的 Bootstrap CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/bootstrap/css/bootstrap.min.css">
        <!-- 引用 jQuery UI CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/jquery/css/jquery-ui.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                display: flex;
                align-items: center;
                min-height: 100vh;
            }

            .register-card {
                max-width: 500px;
                margin: auto;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            }

            .card-header {
                background-color: #0d6efd;
                color: rgb(245, 243, 243);
                border-radius: 15px 15px 15px 15px !important;
                text-align: center;
                padding: 1.5rem;
            }
        </style>
    </head>

    <body>
        <div class="container my-5">
            <div class="card register-card">
                <div class="card-header">
                    <h3 class="mb-0">會員註冊</h3>
                </div>
                <div class="card-body p-4">
                    <form method="post">
                        <div class="mb-3">
                            <label for="userid" class="form-label">使用者帳號</label>
                            <input type="text" class="form-control" id="userid" name="userid" placeholder="請輸入帳號"
                                required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">密碼</label>
                            <input type="password" class="form-control" id="password" name="password"
                                placeholder="請輸入密碼" required>
                            <div id="pwdError" class="invalid-feedback">
                                <!-- 錯誤訊息將由 JavaScript 動態更新 -->
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="realname" class="form-label">真實姓名</label>
                            <input type="text" class="form-control" id="realname" name="realname" placeholder="請輸入真實姓名"
                                required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">電子郵件信箱</label>
                            <input type="email" class="form-control" id="email" name="email"
                                placeholder="example@domain.com" required>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">立即註冊</button>
                            <button type="reset" class="btn btn-outline-secondary">取消</button>
                        </div>
                    </form>

                    <% if (request.getAttribute("msg") !=null) { %>
                        <div class="alert alert-info mt-4 text-center" role="alert">
                            ${msg}
                        </div>
                        <% } %>
                </div>
            </div>
        </div>

        <!-- 引用 jQuery Core -->
        <script src="${pageContext.request.contextPath}/dist/jquery/js/jquery.min.js"></script>
        <!-- 引用 jQuery UI JS -->
        <script src="${pageContext.request.contextPath}/dist/jquery/js/jquery-ui.min.js"></script>
        <!-- 引用專案中的 Bootstrap JS -->
        <script src="${pageContext.request.contextPath}/dist/bootstrap/js/bootstrap.bundle.min.js"></script>

        <script>
            $(document).ready(function () {
                console.log("初始化了...");
                // 選取密碼欄位並綁定游標離開 (blur) 事件
                $('#password').on('blur', function () {
                    let pwd = $(this).val();
                    console.log("密碼:" + pwd);
                    let len = pwd.length;
                    let errorMessages = []; //JS空陣列

                    // 驗證 6-12 字元長度
                    if (len < 6 || len > 12) {
                        errorMessages.push('密碼長度必須在 6-12 字元之間 (含)');
                    }

                    // 驗證至少一個大寫字母
                    if (!/[A-Z]/.test(pwd)) {
                        errorMessages.push('至少需要一個英文大寫字母');
                    }

                    // 驗證至少一個小寫字母
                    if (!/[a-z]/.test(pwd)) {
                        errorMessages.push('至少需要一個英文小寫字母');
                    }

                    // 驗證至少一個數字
                    if (!/[0-9]/.test(pwd)) {
                        errorMessages.push('至少需要一個數字');
                    }

                    // 驗證至少一個特殊符號
                    if (!/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(pwd)) {
                        errorMessages.push('至少需要一個特殊符號 (!@#$%^&*等)');
                    }

                    // 顯示驗證結果
                    if (errorMessages.length > 0) {
                        $(this).addClass('is-invalid');
                        $('#pwdError').html(errorMessages.join('<br>'));
                        $('#pwdError').show();
                    } else {
                        $(this).removeClass('is-invalid');
                        $('#pwdError').hide();
                    }
                });
            });
        </script>
    </body>

    </html>