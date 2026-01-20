package com.beans;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;

import com.microsoft.sqlserver.jdbc.SQLServerDataSource;

//工廠設計模式Factory Design Pattern 準備組態(合約書) 準備原物料 生產產品(給應用系統用)
//定義成應用系統組態配置(Config，註冊在應用系統容器中)
//注入應用系統組態 資源檔Resource File(xml or properties)
@Configuration
@PropertySource("classpath:application.properties")
public class DatabaseBeansConfig {
    // Data Field 使用Spring EL
    @Value("${spring.datasource.url}")
    private String url;
    @Value("${spring.datasource.username}")
    private String userName;
    @Value("${spring.datasource.password}")
    private String password;

    // 配置DataSource元件，工廠只有一個，應用系統共用一個物件
    @Bean
    @Scope("singleton")
    public DataSource dataSource() {
        // 建構一個DataSource物件
        SQLServerDataSource datasource = new SQLServerDataSource(); // 內含有Driver class對應
        // 配置資料庫連接屬性
        datasource.setURL(url);
        datasource.setUser(userName);
        datasource.setPassword(password);
        System.out.println("產生DataSource物件");
        return datasource;
    }

    // 透過方法生產一個Bean(元件) JdbcTemplate
    // 生產JdbcTemplate物件給應用系統(內含有Jdbc DriverManager/java.sql 底層介面以及javax.datasource)
    // 以及實作DAO設計模式的介面規範(CRUD) 對資料的新增修改查詢予刪除等方法操作
    // 依賴一個DataSource(連接工廠)
    // @Bean 內建生命週期為何?(每次注入產生一個物件 或者只有一個物件共用???)
    @Bean
    @Scope("prototype") // 每次被請求就是產生一個新的物件
    public JdbcTemplate jdbcTemplate(DataSource datasource) {
        // JdbcTemplate如果要產生個體物件 需要配置Connection String屬性
        // 建構JdbcTemplate
        JdbcTemplate template = new JdbcTemplate();
        // 配置屬性 setXxx() Property Injection(JdbcTemplate透過屬性注入依賴的連接工廠物件)
        template.setDataSource(datasource);
        try {
            System.out.println("產生JdbcTemplate物件.." + template.getDataSource().getConnection().getCatalog());
        } catch (Exception e) {
            System.err.println("無法取得資料庫 Catalog: " + e.getMessage());
        }
        return template;
    }
}