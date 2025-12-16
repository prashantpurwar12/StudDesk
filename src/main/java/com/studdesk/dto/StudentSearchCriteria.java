package com.studdesk.dto;

// Data Transfer Object for student search criteria.

public class StudentSearchCriteria {

    private String name;
    private String rollNumber;
    private String grade;
    private String email;
    private String gender;
    private String sortBy;
    private String sortOrder;

    public StudentSearchCriteria() {
    }

    public StudentSearchCriteria(String name, String rollNumber, String grade,
            String email, String gender, String sortBy, String sortOrder) {
        this.name = name;
        this.rollNumber = rollNumber;
        this.grade = grade;
        this.email = email;
        this.gender = gender;
        this.sortBy = sortBy;
        this.sortOrder = sortOrder;
    }

    // Getters and Setters

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRollNumber() {
        return rollNumber;
    }

    public void setRollNumber(String rollNumber) {
        this.rollNumber = rollNumber;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getSortBy() {
        return sortBy;
    }

    public void setSortBy(String sortBy) {
        this.sortBy = sortBy;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    @Override
    public String toString() {
        return "StudentSearchCriteria{" +
                "name='" + name + '\'' +
                ", rollNumber='" + rollNumber + '\'' +
                ", grade='" + grade + '\'' +
                ", email='" + email + '\'' +
                ", gender='" + gender + '\'' +
                ", sortBy='" + sortBy + '\'' +
                ", sortOrder='" + sortOrder + '\'' +
                '}';
    }
}
