package com.gen.cinema.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gen.cinema.domain.City;
import com.gen.cinema.dto.response.CinemaResponse;
import com.gen.cinema.dto.response.CityResponse;
import com.gen.cinema.dto.response.MovieResponse;
import com.gen.cinema.repository.CityRepository;
import com.gen.cinema.service.CityService;

@Service
public class CityServiceImpl implements CityService {

    private final CityRepository cityRepository;

    public CityServiceImpl(CityRepository cityRepository) {
        this.cityRepository = cityRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<CityResponse> getAllCities() {
        return cityRepository.findAll().stream()
            .map(this::mapToCityResponse)
            .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<CinemaResponse> getCinemasByCity(Long cityId) {
        
        return cityRepository.findCitiesWithActiveMovies(cityId).stream()
            .flatMap(city -> city.getCityCinemas().stream())
            .map(cityCinema -> new CinemaResponse(
                cityCinema.getCinema().getId(),
                cityCinema.getCinema().getName(),
                cityCinema.getCinema().getAddress(),
                cityCinema.getStudios().stream()
                    .flatMap(studio -> studio.getMovieSchedules().stream())
                    .map(ms -> new MovieResponse(
                        ms.getMovie().getId(),
                        ms.getMovie().getTitle(),
                        ms.getMovie().getDescription(),
                        ms.getMovie().getDuration(),
                        ms.getMovie().getVersion().longValue()
                    ))
                    .distinct()
                    .collect(Collectors.toList()),
                cityCinema.getCinema().getVersion().longValue()
            ))
            .collect(Collectors.toList());
    }

    private CityResponse mapToCityResponse(City city) {
        return new CityResponse(
            city.getId(),
            city.getName(),
            city.getVersion().longValue()
        );
    }
} 