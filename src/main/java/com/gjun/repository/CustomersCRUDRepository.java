package com.gjun.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.gjun.model.MyCustomers;

@Repository
public class CustomersCRUDRepository implements IOperations<MyCustomers, String> {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // 定義 RowMapper 將結果集映射到 MyCustomers 物件
    private RowMapper<MyCustomers> rowMapper = new RowMapper<MyCustomers>() {
        @Override
        public MyCustomers mapRow(ResultSet rs, int rowNum) throws SQLException {
            MyCustomers customer = new MyCustomers();
            customer.setCustomerID(rs.getString("CustomerID"));
            customer.setCompanyName(rs.getString("CompanyName"));
            customer.setContactName(rs.getString("ContactName"));
            customer.setContactTitle(rs.getString("ContactTitle"));
            customer.setAddress(rs.getString("Address"));
            customer.setCity(rs.getString("City"));
            customer.setRegion(rs.getString("Region"));
            customer.setPostalCode(rs.getString("PostalCode"));
            customer.setCountry(rs.getString("Country"));
            customer.setPhone(rs.getString("Phone"));
            customer.setFax(rs.getString("Fax"));
            return customer;
        }
    };

    // 查詢所有客戶資料
    @Override
    public List<MyCustomers> all() throws DataAccessException {
        String sql = "SELECT * FROM Customers";
        return jdbcTemplate.query(sql, rowMapper);
    }

    // 傳遞客戶編號 進行單筆查詢
    @Override
    public MyCustomers findById(String k) throws DataAccessException {
        String sql = "SELECT * FROM Customers WHERE CustomerID = ?";
        return jdbcTemplate.queryForObject(sql, rowMapper, k);
    }

    // 修改客戶資料
    @Override
    public boolean update(MyCustomers source, String key) throws DataAccessException {
        String sql = "UPDATE Customers SET CompanyName = ?, ContactName = ?, ContactTitle = ?, Address = ?, City = ?, Region = ?, PostalCode = ?, Country = ?, Phone = ?, Fax = ? WHERE CustomerID = ?";
        int rows = jdbcTemplate.update(sql,
                source.getCompanyName(),
                source.getContactName(),
                source.getContactTitle(),
                source.getAddress(),
                source.getCity(),
                source.getRegion(),
                source.getPostalCode(),
                source.getCountry(),
                source.getPhone(),
                source.getFax(),
                key);
        return rows > 0;
    }

    // 刪除客戶資料
    @Override
    public boolean delete(String key) throws DataAccessException {
        String sql = "DELETE FROM Customers WHERE CustomerID = ?";
        int rows = jdbcTemplate.update(sql, key);
        return rows > 0;
    }

    // 新增客戶資料
    @Override
    public boolean add(MyCustomers source) throws DataAccessException {
        String sql = "INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        int rows = jdbcTemplate.update(sql,
                source.getCustomerID(),
                source.getCompanyName(),
                source.getContactName(),
                source.getContactTitle(),
                source.getAddress(),
                source.getCity(),
                source.getRegion(),
                source.getPostalCode(),
                source.getCountry(),
                source.getPhone(),
                source.getFax());
        return rows > 0;
    }
}
