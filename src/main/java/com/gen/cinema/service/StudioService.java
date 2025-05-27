package com.gen.cinema.service;

import java.util.List;
import com.gen.cinema.dto.response.StudioResponse;
 
public interface StudioService {
    List<StudioResponse> getStudiosByCinemaId(Long cinemaId);
} 