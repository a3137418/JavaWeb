<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>

    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>登入頁面</title>
    </head>

    <body>
        <!-- 區段 -->
        <div>
            <form method="post">
                <table>
                    <tr>
                        <td>使用者帳號</td>
                        <td><input type="text" name="username"></td>
                    </tr>
                    <tr>
                        <td>使用者密碼</td>
                        <td><input type="password" name="password"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="reset" value="取消">
                            <input type="submit" value="登入">
                        </td>
                    </tr>
                </table>
            </form>
            <h3>${message}</h3>
        </div>
    </body>

    </html>