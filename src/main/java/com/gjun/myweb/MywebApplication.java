package com.gjun.myweb;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.server.servlet.context.ServletComponentScan;
import org.springframework.context.annotation.ComponentScan;

//啟動應用系統同時進行整個專案關於Servlet 部署註冊收集(全部掃進來 註冊)
@SpringBootApplication
@ServletComponentScan(basePackages = { "com.gjun.controller" })
@ComponentScan(basePackages = { "com.gjun.controller", "com.beans" })
public class MywebApplication {

	// Entry Point
	public static void main(String[] args) {
		SpringApplication.run(MywebApplication.class, args);
	}

}
