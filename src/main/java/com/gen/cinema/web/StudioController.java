package com.gen.cinema.web;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gen.cinema.dto.response.StudioResponse;
import com.gen.cinema.service.StudioService;

@RestController
@RequestMapping("/v1/studio")
public class StudioController {

    private final StudioService studioService;

    public StudioController(StudioService studioService) {
        this.studioService = studioService;
    }

    @GetMapping
    public ResponseEntity<List<StudioResponse>> getStudios(@RequestParam("cinema_id") Long cinemaId) {
        return ResponseEntity.ok(studioService.getStudiosByCinemaId(cinemaId));
    }
} 