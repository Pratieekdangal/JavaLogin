package org.example.jobp.model;

import java.sql.Timestamp;

public class Company {
  private int id;
  private String name;
  private String industry;
  private String location;
  private String description;
  private String logoUrl;
  private int userId;
  private Timestamp createdAt;
  private Timestamp updatedAt;
  private String website;
  private String address;
  private String size;
  private Integer foundedYear;

  // Default constructor
  public Company() {
  }

  // Constructor with essential fields
  public Company(String name, String description, String website, String address,
      String size, Integer foundedYear, int userId, String industry) {
    this.name = name;
    this.description = description;
    this.website = website;
    this.address = address;
    this.size = size;
    this.foundedYear = foundedYear;
    this.userId = userId;
    this.industry = industry;
  }

  // Getters and Setters
  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getIndustry() {
    return industry;
  }

  public void setIndustry(String industry) {
    this.industry = industry;
  }

  public String getLocation() {
    return location;
  }

  public void setLocation(String location) {
    this.location = location;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getLogoUrl() {
    return logoUrl;
  }

  public void setLogoUrl(String logoUrl) {
    this.logoUrl = logoUrl;
  }

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  public Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(Timestamp createdAt) {
    this.createdAt = createdAt;
  }

  public Timestamp getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(Timestamp updatedAt) {
    this.updatedAt = updatedAt;
  }

  public String getWebsite() {
    return website;
  }

  public void setWebsite(String website) {
    this.website = website;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public String getSize() {
    return size;
  }

  public void setSize(String size) {
    this.size = size;
  }

  public Integer getFoundedYear() {
    return foundedYear;
  }

  public void setFoundedYear(Integer foundedYear) {
    this.foundedYear = foundedYear;
  }
}