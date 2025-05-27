package com.gen.cinema.web;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gen.cinema.dto.response.CinemaResponse;
import com.gen.cinema.dto.response.CityResponse;
import com.gen.cinema.service.CityService;

@RestController
@RequestMapping("/v1/city")
public class CityResource {

    private final CityService cityService;

    public CityResource(CityService cityService) {
        this.cityService = cityService;
    }

    @GetMapping
    public ResponseEntity<List<CityResponse>> getAllCities() {
        return ResponseEntity.ok(cityService.getAllCities());
    }

    @GetMapping("/{cityId}/cinema")
    public ResponseEntity<List<CinemaResponse>> getCinemasByCity(@PathVariable Long cityId) {
        return ResponseEntity.ok(cityService.getCinemasByCity(cityId));
    }
} 