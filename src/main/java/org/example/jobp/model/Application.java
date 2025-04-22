package org.example.jobp.model;

import java.sql.Timestamp;

public class Application {
  private int id;
  private int jobId;
  private int userId;
  private String resumePath;
  private String coverLetter;
  private Timestamp appliedDate;
  private String status;
  private String applicantName;
  private String applicantEmail;
  private String jobTitle;
  private String companyName;

  // Constructors
  public Application() {
  }

  // Getters and Setters
  public int getId() {
    return id;
  }

  public void setId(int id) {
    this.id = id;
  }

  public int getJobId() {
    return jobId;
  }

  public void setJobId(int jobId) {
    this.jobId = jobId;
  }

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  public String getResumePath() {
    return resumePath;
  }

  public void setResumePath(String resumePath) {
    this.resumePath = resumePath;
  }

  public String getCoverLetter() {
    return coverLetter;
  }

  public void setCoverLetter(String coverLetter) {
    this.coverLetter = coverLetter;
  }

  public Timestamp getAppliedDate() {
    return appliedDate;
  }

  public void setAppliedDate(Timestamp appliedDate) {
    this.appliedDate = appliedDate;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getApplicantName() {
    return applicantName;
  }

  public void setApplicantName(String applicantName) {
    this.applicantName = applicantName;
  }

  public String getApplicantEmail() {
    return applicantEmail;
  }

  public void setApplicantEmail(String applicantEmail) {
    this.applicantEmail = applicantEmail;
  }

  public String getJobTitle() {
    return jobTitle;
  }

  public void setJobTitle(String jobTitle) {
    this.jobTitle = jobTitle;
  }

  public String getCompanyName() {
    return companyName;
  }

  public void setCompanyName(String companyName) {
    this.companyName = companyName;
  }
}