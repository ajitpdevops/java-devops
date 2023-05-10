package com.ideas.springcloud.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthCheckController {
    
    @GetMapping("/health")
    public String healthCheck() {
        return "Product service is up and running";
    }
}
