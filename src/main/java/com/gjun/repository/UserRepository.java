package com.gjun.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.gjun.model.OnLineUsers;

//實作CRUD介面
@Repository
public class UserRepository implements IOperations<OnLineUsers, String> {
    // Data field注入依賴物件JdbcTemplate
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<OnLineUsers> all() throws DataAccessException {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'all'");
    }

    @Override
    public OnLineUsers findById(String k) throws DataAccessException {
        // 帳號密碼傳遞成一個字串，採用，切割
        String[] items = k.split(",");
        OnLineUsers users = null;
        // 查詢敘述設定 採用參數架構
        String sql = "Select Count(*) as counter From OnLineUsers where UserName=? and Password=?";
        // 借助置入JdbcTemplate進行查詢
        int result = jdbcTemplate.queryForObject(sql,
                // RowMapper interface 只有一個抽象方法 採用Lambda
                (r, n) -> {
                    return r.getInt("counter");
                },

                items[0], items[1]);
        // 判斷回應的查詢紀錄數
        if (result == 1) {
            // 會員
            users = new OnLineUsers();
        }
        return users;

    }

    @Override
    public boolean add(OnLineUsers source) throws DataAccessException {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'add'");
    }

    @Override
    public boolean update(OnLineUsers source, String k) throws DataAccessException {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'update'");
    }

    @Override
    public boolean delete(String k) throws DataAccessException {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'delete'");
    }

}
