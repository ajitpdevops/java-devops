package com.ideas.springcloud.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ideas.springcloud.model.Product;

public interface ProductRepo extends JpaRepository <Product, Long> {
    
}
