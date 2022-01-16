package com.ajit.springcloud.repos;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ajit.springcloud.model.Flight;

public interface FlightRepository extends JpaRepository<Flight, Long> {

}
