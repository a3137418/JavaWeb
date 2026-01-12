<!-- JSP Directive 指示詞 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>會員註冊頁面</title>
    </head>

    <body>
        <fieldset>
            <legend>會員註冊-Coontroller應用</legend>
            <div>
                <form method="post">
                    <table>
                        <tr>
                            <td>使用者帳號</td>
                            <td><input type="text" name="userid"></td>
                        </tr>
                        <tr>
                            <td>密碼</td>
                            <td><input type="password" name="password"></td>
                        </tr>
                        <tr>
                            <td>真實姓名</td>
                            <td><input type="text" name="realname"></td>
                        </tr>
                        <tr>
                            <td>電子郵件信箱</td>
                            <td><input type="email" name="email"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="submit" value="註冊">
                                <input type="reset" value="取消">
                            </td>
                        </tr>
                    </table>
                </form>
                <div>
                    <!-- 使用JSP(EL) Expression Language 表達式 運算 就是一行  -->
                    <h3>${msg}</h3>
                </div>
            </div>
        </fieldset>
    </body>

    </html>