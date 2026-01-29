//對資料維護功能規則 規劃介面
package com.gjun.repository;

import java.util.List;

import org.springframework.dao.DataAccessException;

// 使用 Generic 泛型，定義影響方法參數或者是回應值相對型別
public interface IOperations<T, Key> {
    // 定義CRUD方法規範
    // 查詢資料
    public List<T> all() throws DataAccessException;

    // 單筆查詢
    public T findById(Key k) throws DataAccessException;

    // 新增資料
    public boolean add(T source) throws DataAccessException;

    // 修改資料
    public boolean update(T source, Key k) throws DataAccessException;

    // 刪除資料
    public boolean delete(Key k) throws DataAccessException;

}