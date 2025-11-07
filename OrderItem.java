package com.bittercode.model;

import java.io.Serializable;

public class OrderItem implements Serializable {
    
    private int orderItemId;
    private String orderId;
    private String bookBarcode;
    private String bookName;
    private int quantity;
    private double price;
    
    public OrderItem() {
        super();
    }
    
    public OrderItem(int orderItemId, String orderId, String bookBarcode, 
                     int quantity, double price) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.bookBarcode = bookBarcode;
        this.quantity = quantity;
        this.price = price;
    }
    
    public int getOrderItemId() {
        return orderItemId;
    }
    
    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }
    
    public String getOrderId() {
        return orderId;
    }
    
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }
    
    public String getBookBarcode() {
        return bookBarcode;
    }
    
    public void setBookBarcode(String bookBarcode) {
        this.bookBarcode = bookBarcode;
    }
    
    public String getBookName() {
        return bookName;
    }
    
    public void setBookName(String bookName) {
        this.bookName = bookName;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
}
