package com.gen.cinema.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.gen.cinema.dto.response.StudioResponse;
import com.gen.cinema.repository.StudioRepository;
import com.gen.cinema.service.StudioService;

@Service
public class StudioServiceImpl implements StudioService {

    private final StudioRepository studioRepository;

    public StudioServiceImpl(StudioRepository studioRepository) {
        this.studioRepository = studioRepository;
    }

    @Override
    public List<StudioResponse> getStudiosByCinemaId(Long cinemaId) {
        return studioRepository.findByCinemaId(cinemaId)
            .stream()
            .map(s -> new StudioResponse(s.getId(), s.getName()))
            .collect(Collectors.toList());
    }
} 