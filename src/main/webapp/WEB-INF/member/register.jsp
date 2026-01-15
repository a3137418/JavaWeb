<!-- JSP Directive 指示詞 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="zh-Hant">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>會員註冊頁面</title>
        <!-- 引入 Bootstrap CSS -->
        <link href="${pageContext.request.contextPath}/dist/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <!-- 引入 jQuery UI CSS -->
        <link href="${pageContext.request.contextPath}/dist/jquery/css/jquery-ui.min.css" rel="stylesheet">
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
                color: rgb(238, 236, 236);
                border-radius: 15px 15px 15px 15px !important;
                text-align: center;
                padding: 1.5rem;
            }
        </style>
    </head>

    <body class="bg-light">
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
                    <% Object msgAttr=request.getAttribute("msg"); if (msgAttr !=null &&
                        !msgAttr.toString().trim().isEmpty()) { %>
                        <div class="alert alert-info mt-4 text-center" role="alert">
                            ${msg}
                        </div>
                        <% } %>
                </div>
            </div>
        </div>

        <!-- 引入 jQuery Core 與 jQuery UI JS -->
        <script src="${pageContext.request.contextPath}/dist/jquery/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/dist/jquery/js/jquery-ui.min.js"></script>
        <!-- 引入 Bootstrap JS Bundle (包含 Popper) -->
        <script src="${pageContext.request.contextPath}/dist/bootstrap/js/bootstrap.bundle.min.js"></script>

        <script>
            $(document).ready(function () {
                console.log("初始化了...");
                // 使用 jQuery Selector 選取密碼欄位並綁定 blur 事件
                $('#password').on('blur', function () {
                    var password = $(this).val();
                    console.log("密碼:" + password);
                    var $pwdError = $('#pwdError');
                    var errors = [];

                    // 1. 驗證密碼長度是否在 6-12 字元之間(含)
                    if (password.length < 6 || password.length > 12) {
                        errors.push('長度必須在 6-12 字元之間');
                    }

                    // 2. 至少一個大寫英文字元
                    if (!/[A-Z]/.test(password)) {
                        errors.push('必須包含至少一個大寫英文字元');
                    }

                    // 3. 至少一個小寫英文字元
                    if (!/[a-z]/.test(password)) {
                        errors.push('必須包含至少一個小寫英文字元');
                    }

                    // 4. 至少一個數字
                    if (!/[0-9]/.test(password)) {
                        errors.push('必須包含至少一個數字');
                    }

                    // 5. 至少一個特殊符號
                    if (!/[!@#$%^&*(),.?":{}|<>]/.test(password)) {
                        errors.push('必須包含至少一個特殊符號');
                    }
                    //顯示驗證結果
                    if (errors.length > 0) {
                        // 加入 Bootstrap 的 is-invalid 樣式
                        $(this).addClass('is-invalid').removeClass('is-valid');
                        // 顯示錯誤訊息（以分號分隔）
                        $pwdError.text(errors.join('；'));
                    } else {
                        // 移除 invalid 樣式並視需要加入 valid 樣式
                        $(this).removeClass('is-invalid').addClass('is-valid');
                        // 清除錯誤訊息
                        $pwdError.text('');
                    }
                });
            });
        </script>
    </body>

    </html>