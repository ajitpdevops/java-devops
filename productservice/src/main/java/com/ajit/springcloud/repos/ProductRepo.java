package com.ajit.springcloud.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ajit.springcloud.model.Product;

public interface ProductRepo extends JpaRepository<Product, Long> {

}
