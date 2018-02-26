package com.sakadream.test.bean;

public class Employee {
    private int id;
    private String fullName;
    private String address;
    private String email;
    private String phone;
    private int salary;

    public Employee(int id, String fullName, String address, String email, String phone, int salary) {
        this.id = id;
        this.fullName = fullName;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.salary = salary;
    }

    public Employee(String fullName, String address, String email, String phone, int salary) {
        this.fullName = fullName;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.salary = salary;
    }
    
    public int getId() {
        return this.id;
    }
    
    public String getFullName() {
        return this.fullName;
    }
    public String getAddress() {
        return this.address;
    }
    public String getEmail() {
        return this.email;
    }
    public String getPhone() {
        return this.phone;
    }
    public int getSalary() {
        return this.salary;
    }
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public void setSalary(int salary) {
        this.salary = salary;
    }
}