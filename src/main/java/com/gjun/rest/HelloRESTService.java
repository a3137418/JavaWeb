package com.gjun.rest;

import com.gjun.model.Message;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

//RESTful服務，提供打招呼功能
//使用Annotation 標註這是一個REST Controller
@RestController
@RequestMapping("/api/v1/hello") // 支援哪一種傳送方式???
public class HelloRESTService {
    // 回應一個簡單字串
    @RequestMapping("/greeting")
    public String hello() {
        return "Hello, World!";
    }

    // 借助Path當作參數，傳遞誰來打招呼
    // 設定請求方式Path當作參數，沒有設定Reponse Header Content-Type
    @GetMapping("/who/{w}")
    public String hellowho(@PathVariable(name = "w", required = true) String who) {
        String content = String.format("<font size='6' color='red'>%s 您好!!!</font>", who);
        return content;
    }

    // 採用QueryString傳遞參數 http://hosted/xxx/xxx?參數=value&....
    // produces attribute 設定 Response Header Content-Type:applicatiion/json
    @GetMapping(value = "/who/query", produces = MediaType.APPLICATION_JSON_VALUE)
    public Message helloQuery(@RequestParam(name = "who", required = false, defaultValue = "張三豐") String who) {
        // 建構Message物件
        Message message = new Message();
        message.setCode(200);
        message.setMsg(who + "您好");
        return message;// OTD(object to data) 將技藝物件序列化成json文字
    }
}
