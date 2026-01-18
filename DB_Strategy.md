# MyWeb 專案資料庫存取策略分析

## 1. 專案現況概述
目前 `MyWeb` 專案採用 **Spring Boot** 作為基礎框架，並混合使用原生 **Servlet** (`@WebServlet`) 進行請求處理。

### 現有配置檢查
- **依賴管理 (`pom.xml`)**:
  - 已包含 `mssql-jdbc` (Microsoft SQL Server JDBC Driver)，使用了 SQL Server 資料庫。
  - **缺少** `spring-boot-starter-jdbc` 或 `spring-boot-starter-data-jpa`，這表示目前尚未啟用 Spring Boot 的自動配置 DataSource 功能。
- **程式碼結構**:
  - `MemberRegister.java` (Servlet) 中包含 `TODO` 註解，表示資料庫寫入邏輯尚未實作。
  - 目前尚未發現 DAO (Data Access Object) 或 Repository 層級的程式碼。
- **設定檔 (`application.properties`)**:
  - 尚未設定資料庫連線資訊 (URL, Username, Password)。

---

## 2. 建議的資料庫存取策略架構

基於目前的專案結構（Spring Boot + Servlet），建議採用標準的 **MVC 分層架構** 配合 **DAO 設計模式**。

### 技術選型
- **資料庫**: Microsoft SQL Server
- **驅動程式**: MSSQL JDBC (`com.microsoft.sqlserver.jdbc.SQLServerDriver`)
- **存取技術**: 
  - **JDBC (Java Database Connectivity)**: 鑑於這是一個「Java Web 全端開發實務」專案，通常會從基礎的 JDBC 開始實作，以了解底層運作。
  - **DataSource (連接池)**: 建議引入 `spring-boot-starter-jdbc` 以利用 HikariCP 連接池管理連線，避免每次請求都重新建立連線 (DriverManager) 的效能損耗。

### 架構設計圖

```mermaid
graph TD
    User[使用者瀏覽器] -->|HTTP Request| Controller[Servlet 控制器 (Controller)]
    Controller -->|DTO/VO| Service[業務邏輯層 (Service) - Optional]
    Service -->|DTO/VO| DAO[資料存取層 (DAO Pattern)]
    
    subgraph Database Layer
        DAO -->|JDBC SQL Command| DataSource[DataSource (Connection Pool)]
        DataSource -->|TCP/IP| DB[(SQL Server Database)]
    end

    classDef java fill:#f9f,stroke:#333,stroke-width:2px;
    classDef db fill:#ff9,stroke:#333,stroke-width:2px;
    class Controller,Service,DAO java;
    class DB db;
```

---

## 3. 實作規劃建議

### 階段一：環境配置 (Configuration)
1.  **修改 `pom.xml`**: 加入 `spring-boot-starter-jdbc` 依賴（管理連接池）。
2.  **設定 `application.properties`**:
    ```properties
    spring.datasource.url=jdbc:sqlserver://localhost:1433;databaseName=YourDB;encrypt=true;trustServerCertificate=true;
    spring.datasource.username=your_user
    spring.datasource.password=your_password
    spring.datasource.driver-class-name=com.microsoft.sqlserver.jdbc.SQLServerDriver
    ```

### 階段二：建立 DAO 層 (Data Access Layer)
建立 `com.gjun.dao` 套件，並實作會員資料的存取介面與實作類別。

- **MemberDao (Interface)**: 定義 `save`, `findByUserId` 等方法。
- **MemberDaoImpl (Class)**:
    - 使用 `@Repository` 註解交由 Spring 管理。
    - 注入 `DataSource` 或 `JdbcTemplate` 進行 SQL 操作。

### 階段三：整合 Controller
在 `MemberRegister` Servlet 中：
1.  取得 DAO 實例 (可透過 Spring Context 取得 Bean 或簡易的 Singleton 模式，視是否完全整合 Spring DI 而定)。
2.  在 `doPost` 方法中呼叫 DAO 將表單資料寫入資料庫。

## 4. 總結
目前專案處於資料庫整合的**準備階段**。已具備驅動程式，但需補足組態設定與存取層程式碼。建議採用 **Spring JDBC (JdbcTemplate)** 簡化傳純 JDBC 的繁瑣代碼，同時保留對 SQL 的直接控制能力。
