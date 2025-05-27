package com.gen.cinema.service.impl;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.TextStyle;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.gen.cinema.domain.Movie;
import com.gen.cinema.domain.MovieSchedule;
import com.gen.cinema.dto.response.MovieScheduleDayResponse;
import com.gen.cinema.dto.response.ShowTimeResponse;
import com.gen.cinema.dto.response.MovieScheduleResponse;
import com.gen.cinema.repository.MovieScheduleRepository;
import com.gen.cinema.service.MovieScheduleService;
import com.gen.cinema.util.DateUtils;

@Service
public class MovieScheduleServiceImpl implements MovieScheduleService {

    private final MovieScheduleRepository movieScheduleRepository;

    public MovieScheduleServiceImpl(MovieScheduleRepository movieScheduleRepository) {
        this.movieScheduleRepository = movieScheduleRepository;
    }

    @Override
    public MovieScheduleResponse getMovieSchedules(Long movieId, Long studioId) {
       
        LocalDate today = LocalDate.now();
        LocalDateTime start = today.atStartOfDay();
        LocalDateTime end = today.plusDays(3).atTime(23, 59, 59);
        
        List<MovieSchedule> schedules = movieScheduleRepository
                                .findSchedules(movieId, studioId, start, end);
        
        if (CollectionUtils.isEmpty(schedules)) {
            return new MovieScheduleResponse(null, List.of());
        }
        
        Map<LocalDate, List<MovieSchedule>> grouped = schedules.stream()
            .collect(Collectors.groupingBy(ms -> ms.getStartTime().toLocalDate()));
        
            List<MovieScheduleDayResponse> dayResponses = grouped.entrySet().stream()
            .sorted(Map.Entry.comparingByKey())
            .map(entry -> {
                LocalDate date = entry.getKey();
                List<ShowTimeResponse> showtimes = entry.getValue().stream()
                    .map(ms -> new ShowTimeResponse(
                        ms.getSecureId().toString(),
                        DateUtils.formatDateTime(ms.getStartTime()).substring(11),
                        ms.getVersion().longValue()
                    ))
                    .sorted((a, b) -> a.time().compareTo(b.time()))
                    .collect(Collectors.toList());
                String dayName = date.getDayOfWeek().getDisplayName(TextStyle.FULL, Locale.ENGLISH);
                String studioName = entry.getValue().isEmpty() ? null : entry.getValue().get(0).getStudio().getName();
                return new MovieScheduleDayResponse(
                    date.toString(),
                    dayName,
                    showtimes,
                    studioName,
                    null // movie detail will be in header
                );
            })
            .collect(Collectors.toList());
            
        // Get movie detail from the first schedule
        MovieScheduleDayResponse.MovieDetail movieDetail = null;
        if (!schedules.isEmpty()) {
            Movie m = schedules.get(0).getMovie();
            movieDetail = new MovieScheduleDayResponse.MovieDetail(
                m.getId(),
                m.getTitle(),
                m.getDescription(),
                m.getDuration(),
                m.getSynopsis()
            );
        }
        return new MovieScheduleResponse(movieDetail, dayResponses);
    }
} 