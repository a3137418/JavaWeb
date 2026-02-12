package com.gjun.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Value;

//設計前端登入驗證之後憑證(Cookie)攔截處理
//設計一個Interceptor 架構
@WebFilter(urlPatterns = { "/*" })
public class UserValidFilter implements Filter {

    @Value("${spring.security.path}")
    private String securityPaths;

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        // 佈署在網站上 通訊協定會到Http
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        // 判斷使用者端請求的端點(End Point)
        String path = request.getServletPath();
        System.out.println("使用者請求的端點:" + path);

        // 排除 API 端點和靜態資源，不需要安全驗證
        if (path.startsWith("/api/") || path.startsWith("/js/") ||
                path.startsWith("/css/") || path.startsWith("/images/")) {
            chain.doFilter(request, response);
            return;
        }

        // 取得設定的安全目錄清單
        String[] securityPathArray = securityPaths.split(";");
        boolean isSecurityPath = false;
        for (String sPath : securityPathArray) {
            if (path.startsWith(sPath)) {
                isSecurityPath = true;
                break;
            }
        }

        // 比對使用提出的端點
        if (isSecurityPath) {
            // 驗證前端憑證
            Cookie[] cookies = request.getCookies();
            // 判斷
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    // 看看Cookie name是否為.cred
                    if (cookie.getName().equals(".cred")) {
                        // 要進行Doube check 比對Session
                        if (request.getSession(false) != null) {
                            // 既定Session attribute
                            if (request.getSession(false).getAttribute(".cred") != null) {
                                String sessionValue = (String) request.getSession(false).getAttribute(".cred");
                                if (cookie.getValue().equals(sessionValue)) {
                                    // 合法使用者
                                    chain.doFilter(request, response);
                                    return; // 必須 return，否則會繼續往下執行 redirect
                                }
                            }
                        }
                    }
                }
            }
            // 進行相對目錄判斷 是否需要啟動安全驗證(是否要看看前端是否登入驗證憑證)
            System.out.println("安全目錄驗證失敗，攔截請求...");
            // 重新導向登入頁面
            response.sendRedirect("/login");
        } else {
            // 不驗證
            // 一律往下走
            chain.doFilter(request, response);
        }
        // 回應也有經過這裡...????

    }

    // 聆聽該Filter產生一個個體物件 進行初始化
    public void init(FilterConfig config) {
        System.out.println("User Valid Filter產生個體物件");
    }

}