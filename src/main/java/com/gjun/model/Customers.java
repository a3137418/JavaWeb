package com.gjun.model;

//JavaBean 封裝欄位 產生 setter and getter
public class Customers {
    // 封裝資料欄為
    private String userName;
    private String password;
    private String realName;
    private String email;

    // 產生setter and getter
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
