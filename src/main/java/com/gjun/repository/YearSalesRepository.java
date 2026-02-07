package com.gjun.repository;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import com.gjun.model.YearSales;

/**
 * YearSalesRepository 實作 IOperations 介面
 * 負責年度銷售資料的查詢
 */
@Repository
public class YearSalesRepository implements IOperations<YearSales, Integer> {

    private final JdbcTemplate jdbcTemplate;

    // 依賴注入 JdbcTemplate
    @Autowired
    public YearSalesRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * 呼叫資料庫中的 YearSalesQry Stored Procedure
     * 傳入查詢年度進行查詢
     * 
     * @param year 查詢年度
     * @return 該年度的銷售資料清單
     */
    public List<YearSales> findByYear(Integer year) throws DataAccessException {
        String sql = "{call YearSalesQry(?)}";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(YearSales.class), year);
    }

    @Override
    public List<YearSales> all() throws DataAccessException {
        // 若需求是查詢所有年度，在此實作；目前以 findByYear 為主
        throw new UnsupportedOperationException("尚未實作 all() 方法，請使用 findByYear(year)");
    }

    @Override
    public YearSales findById(Integer k) throws DataAccessException {
        // 若 Key 為 Integer 且代表年度，可導向 findByYear，但 findByYear 回傳 List
        throw new UnsupportedOperationException("尚未實作 findById() 方法");
    }

    @Override
    public boolean update(YearSales source, Integer key) throws DataAccessException {
        throw new UnsupportedOperationException("尚未實作 update() 方法");
    }

    @Override
    public boolean delete(Integer key) throws DataAccessException {
        throw new UnsupportedOperationException("尚未實作 delete() 方法");
    }

    @Override
    public boolean add(YearSales source) throws DataAccessException {
        throw new UnsupportedOperationException("尚未實作 add() 方法");
    }
}