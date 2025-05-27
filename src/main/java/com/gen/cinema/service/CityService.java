package com.gen.cinema.service;

import java.util.List;

import com.gen.cinema.dto.response.CityResponse;
import com.gen.cinema.dto.response.CinemaResponse;

public interface CityService {
    List<CityResponse> getAllCities();
    List<CinemaResponse> getCinemasByCity(Long cityId);
} 