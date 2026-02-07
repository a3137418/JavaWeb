package com.gjun.model;

/**
 * JavaBean 封裝 YearSales 欄位
 * 包含 Year, ProductID, ProductName, TotalAmt, TotalQty
 */
public class YearSales {
    // 封裝資料欄位
    private int year;
    private int productID;
    private String productName;
    private double totalAmt;
    private int totalQty;

    // 預設建構子
    public YearSales() {
    }

    // 產生 setter 與 getter
    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getTotalAmt() {
        return totalAmt;
    }

    public void setTotalAmt(double totalAmt) {
        this.totalAmt = totalAmt;
    }

    public int getTotalQty() {
        return totalQty;
    }

    public void setTotalQty(int totalQty) {
        this.totalQty = totalQty;
    }

    @Override
    public String toString() {
        return "YearSales [year=" + year + ", productID=" + productID + ", productName=" + productName +
                ", totalAmt=" + totalAmt + ", totalQty=" + totalQty + "]";
    }
}