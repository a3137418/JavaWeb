package com.gjun.rest;
//提供可以進行資料維護的RESTful API

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.gjun.model.Message;
import com.gjun.model.MyCustomers;
import com.gjun.repository.CustomersCRUDRepository;

//定義入口端點
@RestController
@RequestMapping("/api/v1/customers")
public class CustomersRESTService {
    // Data Field 注入依賴的物件(實現DI工程)
    @Autowired
    private CustomersCRUDRepository repository;

    // 提供一個端點進行所有客戶資料查詢
    // 採用Request Method-GET 配合查詢作業
    @GetMapping(value = "/all", produces = "application/json")
    public List<MyCustomers> customersAll() {
        // 借助依賴的注入的Repository物件進行功能呼叫
        List<MyCustomers> data = repository.all();
        return data;

    }

    // 傳遞客戶編號 找出相對客戶資料(採用Path as Parameter)
    // Content-Type 稱呼為MIME Type
    @GetMapping(value = "/qry/{id}", produces = "application/json")
    public ResponseEntity<Object> findById(@PathVariable(name = "id", required = true) String customerID) {
        // 借助注入的Repository物件進行查詢
        MyCustomers customers = null;
        try {
            customers = repository.findById(customerID);
        } catch (DataAccessException ex) {
            System.out.println(ex.getMessage());
        }
        if (customers == null) {
            Message message = new Message();
            message.setCode(404);
            message.setMsg("查無客戶編號" + customerID + "客戶資料!!");
            // 產生回應ResponseEntity物件，帶狀態碼404
            return ResponseEntity.status(404).body(message);

        } else {
            // 回應Response status code-200 同時回應OtD物件
            return ResponseEntity.ok()
                    .body(customers);
        }
    }

}