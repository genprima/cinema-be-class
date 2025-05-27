package com.gen.cinema.web;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gen.cinema.dto.response.MovieScheduleResponse;
import com.gen.cinema.service.MovieScheduleService;

@RestController
@RequestMapping("/v1/movie-schedule")
public class MovieScheduleController {

    private final MovieScheduleService movieScheduleService;

    public MovieScheduleController(MovieScheduleService movieScheduleService) {
        this.movieScheduleService = movieScheduleService;
    }

    @GetMapping
    public ResponseEntity<MovieScheduleResponse> getSchedules(
        @RequestParam("movie_id") Long movieId,
        @RequestParam(value = "studio_id", required = false) Long studioId
    ) {
        return ResponseEntity.ok(movieScheduleService.getMovieSchedules(movieId, studioId));
    }
} 