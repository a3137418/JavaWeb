package com.gjun.rest;
//提供可以進行資料維護的RESTful API

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gjun.model.Message;
import com.gjun.model.MyCustomers;
import com.gjun.repository.CustomersCRUDRepository;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

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
        // 借助注入的Repository 進行查詢
        MyCustomers customers = null;
        try {
            customers = repository.findById(customerID);
        } catch (DataAccessException ex) {
            System.out.println(ex.getMessage());

        }
        if (customers == null) {
            Message message = new Message();
            message.setCode(404);
            message.setMsg("查無客戶編號:" + customerID + " 客戶資料!!");
            // 產生回應ResponseEntity物件 帶狀態碼404
            return ResponseEntity.status(404)
                    .body(message);

        } else {
            // 回應Response status code-200 同時回應OtD
            return ResponseEntity.ok()
                    .body(customers);
        }

    }

    // 新增客戶資料
    // Request Method-POST 採用Body 注入DTO(MyCustomers JavaBean)
    @PostMapping(path = "/add", consumes = { "application/json" }, produces = "application/json;charset=UTF-8")
    public ResponseEntity<Message> addCustomers(@RequestBody MyCustomers customers) {
        Message message = null;
        try {
            boolean result = this.repository.add(customers);
            if (result) {
                message = new Message();
                message.setCode(200);
                message.setMsg("客戶編號:" + customers.getCustomerID() + " 新增成功!!!");
                return ResponseEntity.ok(message);
            } else {
                message = new Message();
                message.setCode(400);
                message.setMsg("新增失敗，請確認資料是否正確!!");
                return ResponseEntity.status(400).body(message);
            }
        } catch (DataAccessException ex) {
            message = new Message();
            message.setCode(500);
            message.setMsg("伺服器錯誤:" + ex.getMessage());
            return ResponseEntity.status(500).body(message);
        }
    }

    // 修改 傳遞相對json資料 to Object，跟相對客戶編號 進行修改作業
    // Request Method-PUT 採用Body 注入DTO 注入一個JavaBean 硬性規定前端採用Request Header
    // Content-Type:application/json (MIME Type)
    @PutMapping(path = "/update/{id}", consumes = { "application/json" }, produces = "application/json;charset=UTF-8")
    public ResponseEntity<Message> updateCustomers(@RequestBody MyCustomers customers,
            @PathVariable("id") String customerID) {
        // 借助注入依賴的Repository物件進行更新資料作業
        // 進行邏輯驗證 趨向Business Rule 先進行是否有這一筆客戶資料
        Message message = null;

        try {
            MyCustomers cust = this.repository.findById(customerID);
            // 有這一筆客戶 進行更新
            boolean result = this.repository.update(customers, customerID);
            System.out.println("更新狀態:" + result);
            // 是否有更新到資料
            // 回應訊息
            message = new Message();
            message.setCode(200);
            message.setMsg("客戶資料:" + customerID + " 更新成功!!!");
            return ResponseEntity.ok(message); // ok Http status 200

        } catch (DataAccessException ex) {
            // 找不到 或者例外
            // 回資訊 Message物件 OTOD
            message = new Message();
            message.setCode(404);
            message.setMsg("客戶編號:" + customerID + " 不存在!!");
            return ResponseEntity.status(404).body(message);
        }
    }

    // 刪除 傳遞客戶編號 進行刪除作業
    // Request Method-DELETE
    @DeleteMapping(path = "/delete/{id}", produces = "application/json;charset=UTF-8")
    public ResponseEntity<Message> deleteCustomers(@PathVariable("id") String customerID) {
        Message message = null;
        try {
            // 執行刪除作業
            boolean result = this.repository.delete(customerID);
            if (result) {
                message = new Message();
                message.setCode(200);
                message.setMsg("客戶編號:" + customerID + " 刪除成功!!!");
                return ResponseEntity.ok(message);
            } else {
                message = new Message();
                message.setCode(404);
                message.setMsg("刪除失敗，找不到客戶編號:" + customerID + " !!");
                return ResponseEntity.status(404).body(message);
            }
        } catch (DataAccessException ex) {
            message = new Message();
            message.setCode(500);
            message.setMsg("伺服器錯誤:" + ex.getMessage());
            return ResponseEntity.status(500).body(message);
        }
    }

}