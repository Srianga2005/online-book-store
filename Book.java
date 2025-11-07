package com.bittercode.model;

import java.io.Serializable;

public class Book implements Serializable {

    private String barcode;
    private String name;
    private String author;
    private double price;
    private int quantity;
    private String category;
    private String description;
    private String imageUrl;

    public Book(String barcode, String name, String author, double price, int quantity) {
        this.barcode = barcode;
        this.name = name;
        this.author = author;
        this.setPrice(price);
        this.quantity = quantity;
        this.category = "General";
        this.description = "";
        this.imageUrl = "";
    }
    
    public Book(String barcode, String name, String author, double price, int quantity, 
                String category, String description, String imageUrl) {
        this.barcode = barcode;
        this.name = name;
        this.author = author;
        this.setPrice(price);
        this.quantity = quantity;
        this.category = category;
        this.description = description;
        this.imageUrl = imageUrl;
    }

    public Book() {
        super();
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

}
