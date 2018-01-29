/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.Product;
import java.util.List;

/**
 * @author namph
 */
public interface ProductDao {

    public List<Product> getListProduct(Product product);

    public int addProduct(Product product);

    public int editProduct(Product product);

    public Product getProductByid(Integer id);
    
     public int getCount(Product product);
}
