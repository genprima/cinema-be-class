package com.gen.cinema.service;

import com.gen.cinema.dto.response.MovieScheduleResponse;
 
public interface MovieScheduleService {
    MovieScheduleResponse getMovieSchedules(Long movieId, Long studioId);
} 