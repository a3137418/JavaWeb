---
name: rest-controller
description: Spring Boot RESTful 控制器開發規範與範本。
---

# Spring Boot RESTful 控制器實作規範

定義基於 Spring Boot 的 RESTful API 控制器開發流程，適用於前後端分離架構。

## 實作程序

1. **定義控制器**: 使用 `@RestController` 註解標記。
2. **定義路徑映射**: 使用 `@RequestMapping` 在類別級別定義基本路徑。
3. **HTTP 方法映射**: 使用 `@GetMapping`, `@PostMapping`, `@PutMapping`, `@DeleteMapping` 對應動作。
4. **資料繫結**: 使用 `@RequestParam`, `@PathVariable`, `@RequestBody` 接收輸入。
5. **商業邏輯調用**: 依賴注入 (DI) Service 實體並呼叫。
6. **回應處理**: 返回實體對象，Spring 會自動序列化為 JSON。

## 代碼範本

```java
package com.example.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/v1/customers")
public class CustomerRestController {

    @Autowired
    private CustomerService customerService;

    // 獲取所有客戶 (GET)
    @GetMapping
    public ResponseEntity<List<Customer>> getAll() {
        return ResponseEntity.ok(customerService.findAll());
    }

    // 根據 ID 獲取客戶 (GET)
    @GetMapping("/qry/{id}")
    public ResponseEntity<Customer> getById(@PathVariable Long id) {
        Customer customer = customerService.findById(id);
        return customer != null ? ResponseEntity.ok(customer) : ResponseEntity.notFound().build();
    }

    // 新增客戶 (POST)
    @PostMapping
    public ResponseEntity<Customer> create(@RequestBody Customer customer) {
        Customer saved = customerService.save(customer);
        return ResponseEntity.status(201).body(saved);
    }
}
```

## 最佳實踐
- 使用 `ResponseEntity` 以獲得對 HTTP 狀態碼與標頭的完整控制。
- 統一錯誤處理：使用 `@RestControllerAdvice` 處理例外。
- 保持路徑資源化 (使用複數名詞，如 `/api/customers`)。
