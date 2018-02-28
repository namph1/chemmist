/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.Customer;
import java.util.List;

/**
 *
 * @author namph
 */
public interface CustomerDao {

    List<Customer> getListCustomer(Customer customer);

    int getCount(Customer customer);

    int edit(Customer customer) throws Exception;

    Customer getCustomerById(Integer customerid, boolean isLazy);
}
