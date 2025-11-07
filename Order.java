package com.bittercode.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

public class Order implements Serializable {
    
    private String orderId;
    private String userEmail;
    private Timestamp orderDate;
    private double totalAmount;
    private String status; // Pending, Processing, Shipped, Delivered, Cancelled
    private String shippingAddress;
    private List<OrderItem> orderItems;
    
    public Order() {
        super();
    }
    
    public Order(String orderId, String userEmail, Timestamp orderDate, double totalAmount, 
                 String status, String shippingAddress) {
        this.orderId = orderId;
        this.userEmail = userEmail;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.shippingAddress = shippingAddress;
    }
    
    public String getOrderId() {
        return orderId;
    }
    
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    
    public Timestamp getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }
    
    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getShippingAddress() {
        return shippingAddress;
    }
    
    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
    
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }
    
    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
}
