package com.bittercode.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Review implements Serializable {
    
    private int reviewId;
    private String bookBarcode;
    private String bookName;
    private String userEmail;
    private String userName;
    private int rating;
    private String reviewText;
    private Timestamp reviewDate;
    private boolean isApproved;
    
    public Review() {
        super();
    }
    
    public Review(int reviewId, String bookBarcode, String userEmail, int rating, 
                  String reviewText, Timestamp reviewDate, boolean isApproved) {
        this.reviewId = reviewId;
        this.bookBarcode = bookBarcode;
        this.userEmail = userEmail;
        this.rating = rating;
        this.reviewText = reviewText;
        this.reviewDate = reviewDate;
        this.isApproved = isApproved;
    }
    
    public int getReviewId() {
        return reviewId;
    }
    
    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
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
    
    public String getUserEmail() {
        return userEmail;
    }
    
    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }
    
    public String getUserName() {
        return userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public String getReviewText() {
        return reviewText;
    }
    
    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }
    
    public Timestamp getReviewDate() {
        return reviewDate;
    }
    
    public void setReviewDate(Timestamp reviewDate) {
        this.reviewDate = reviewDate;
    }
    
    public boolean isApproved() {
        return isApproved;
    }
    
    public void setApproved(boolean approved) {
        isApproved = approved;
    }
}
