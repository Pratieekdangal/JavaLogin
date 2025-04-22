package org.example.jobp.model;

import java.sql.Timestamp;

public class Job {
  private int id;
  private String title;
  private String department;
  private String type;
  private String experienceLevel;
  private String location;
  private String salary;
  private String description;
  private String requirements;
  private String benefits;
  private Timestamp applicationDeadline;
  private int companyId;
  private String companyName;
  private Timestamp postedDate;
  private String status;

  // Default constructor
  public Job() {
  }

  // Getters and Setters
  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getDepartment() {
    return department;
  }

  public void setDepartment(String department) {
    this.department = department;
  }

  public String getType() {
    return type;
  }

  public void setType(String type) {
    this.type = type;
  }

  public String getExperienceLevel() {
    return experienceLevel;
  }

  public void setExperienceLevel(String experienceLevel) {
    this.experienceLevel = experienceLevel;
  }

  public String getLocation() {
    return location;
  }

  public void setLocation(String location) {
    this.location = location;
  }

  public String getSalary() {
    return salary;
  }

  public void setSalary(String salary) {
    this.salary = salary;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getRequirements() {
    return requirements;
  }

  public void setRequirements(String requirements) {
    this.requirements = requirements;
  }

  public String getBenefits() {
    return benefits;
  }

  public void setBenefits(String benefits) {
    this.benefits = benefits;
  }

  public Timestamp getApplicationDeadline() {
    return applicationDeadline;
  }

  public void setApplicationDeadline(Timestamp applicationDeadline) {
    this.applicationDeadline = applicationDeadline;
  }

  public int getCompanyId() {
    return companyId;
  }

  public void setCompanyId(int companyId) {
    this.companyId = companyId;
  }

  public String getCompanyName() {
    return companyName;
  }

  public void setCompanyName(String companyName) {
    this.companyName = companyName;
  }

  public Timestamp getPostedDate() {
    return postedDate;
  }

  public void setPostedDate(Timestamp postedDate) {
    this.postedDate = postedDate;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }
}