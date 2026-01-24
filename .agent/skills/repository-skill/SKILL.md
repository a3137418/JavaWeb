---
name: repository-skill
description: 建立一個 Repository 或者建立一個CRUD Repository。
---
# Java Web Repository 層開發規範


## 1. 職責定義
Repository 層負責與資料持久化層（Database）進行交互，封裝所有資料存取邏輯，並將資料庫結果映射為領域實體（Entity）。

## 2. 命名規範
*   **介面命名**：`{EntityName}Repository`（例如：`UserRepository`）。
*   **實體命名**：`{EntityName}Entity` 或直接使用 `{EntityName}`。
*   **方法命名**：遵循 Spring Data JPA 命名慣例：
    *   查詢：`findBy...`, `existsBy...`, `countBy...`
    *   刪除：`deleteBy...`



## 3. 介面定義範例 (Spring Data JPA)
```java
@Repository
public class {自訂名稱}Repository implements {Repository介面}<EntityClass,Key>{
    ...
}

```

## 5. 開發準則
1.  **禁止在 Repository 處理業務邏輯**：Repository 僅負責 CRUD 與資料篩選。
2.  **唯讀優化**：對於僅查詢的操作，建議在 Service 層標註 `@Transactional(readOnly = true)`。
3.  **避免 Select ***：明確指定需要的欄位，或使用 Projections 減少資料傳輸。
4.  
## 6. 異常處理
*   Repository 層不應主動拋出業務異常。
*   對於「找不到資料」的情況，建議回傳 `Optional<T>` 由 Service 層決定如何處理。
```