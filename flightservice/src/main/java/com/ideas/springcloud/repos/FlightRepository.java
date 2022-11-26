package com.ideas.springcloud.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ideas.springcloud.model.Flight;

public interface FlightRepository extends JpaRepository<Flight, Long> {
    
}
