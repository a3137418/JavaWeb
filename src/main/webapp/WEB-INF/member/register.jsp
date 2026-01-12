<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="zh-TW">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>會員註冊 - MyWeb</title>
        <style>
            :root {
                --primary-color: #6366f1;
                --primary-hover: #4f46e5;
                --bg-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                --glass-bg: rgba(255, 255, 255, 0.95);
                --text-color: #1f2937;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
                background: var(--bg-gradient);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0;
                color: var(--text-color);
            }

            .register-container {
                background: var(--glass-bg);
                padding: 2.5rem;
                border-radius: 1.5rem;
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                width: 100%;
                max-width: 400px;
                animation: fadeIn 0.6s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            h1 {
                text-align: center;
                margin-bottom: 2rem;
                font-weight: 700;
                color: #111827;
                letter-spacing: -0.025em;
            }

            .form-group {
                margin-bottom: 1.5rem;
            }

            label {
                display: block;
                margin-bottom: 0.5rem;
                font-size: 0.875rem;
                font-weight: 500;
                color: #374151;
            }

            input {
                width: 100%;
                padding: 0.75rem 1rem;
                border: 1px solid #d1d5db;
                border-radius: 0.5rem;
                font-size: 1rem;
                transition: all 0.2s;
                box-sizing: border-box;
            }

            input:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
            }

            button {
                width: 100%;
                padding: 0.75rem;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 0.5rem;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.2s;
                margin-top: 1rem;
            }

            button:hover {
                background-color: var(--primary-hover);
            }

            .footer-text {
                text-align: center;
                margin-top: 1.5rem;
                font-size: 0.875rem;
                color: #6b7280;
            }

            .footer-text a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
            }

            .footer-text a:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>
        <div class="register-container">
            <h1>會員註冊</h1>
            <form action="${pageContext.request.contextPath}/register" method="POST">
                <div class="form-group">
                    <label for="account">使用者帳號</label>
                    <input type="text" id="account" name="account" placeholder="請輸入帳號" required>
                </div>
                <div class="form-group">
                    <label for="password">使用者密碼</label>
                    <input type="password" id="password" name="password" placeholder="請輸入密碼" required>
                </div>
                <div class="form-group">
                    <label for="realName">真實姓名</label>
                    <input type="text" id="realName" name="realName" placeholder="請輸入您的真實姓名" required>
                </div>
                <div class="form-group">
                    <label for="email">電子信箱</label>
                    <input type="email" id="email" name="email" placeholder="example@domain.com" required>
                </div>
                <button type="submit">立即註冊</button>
            </form>
            <div class="footer-text">
                已經有帳號了？ <a href="${pageContext.request.contextPath}/login">登入</a>
            </div>
        </div>
    </body>

    </html>