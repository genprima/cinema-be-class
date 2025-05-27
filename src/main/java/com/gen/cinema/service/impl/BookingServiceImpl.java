package com.gen.cinema.service.impl;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.gen.cinema.dto.response.BookingScheduleResponse;
import com.gen.cinema.dto.response.BookingSeatResponse;
import com.gen.cinema.repository.MovieScheduleSeatRepository;
import com.gen.cinema.service.BookingService;
import com.gen.cinema.domain.MovieScheduleSeat;
import com.gen.cinema.util.DateUtils;

@Service
public class BookingServiceImpl implements BookingService {

    private final MovieScheduleSeatRepository movieScheduleSeatRepository;

    public BookingServiceImpl(MovieScheduleSeatRepository movieScheduleSeatRepository) {
        this.movieScheduleSeatRepository = movieScheduleSeatRepository;
    }

    @Override
    public BookingScheduleResponse getScheduleSeats(String scheduleId) {
        UUID uuid = UUID.fromString(scheduleId);
        List<MovieScheduleSeat> movieScheduleSeats = movieScheduleSeatRepository.findByScheduleSecureIdOrdered(uuid);
       
        String startTime = null;
        if (!movieScheduleSeats.isEmpty()) {
            startTime = DateUtils.formatDateTime(movieScheduleSeats.get(0)
                       .getMovieSchedule().getStartTime());
        }
       
        List<BookingSeatResponse> seats = movieScheduleSeats.stream()
            .map(mss -> {
                com.gen.cinema.domain.StudioSeat studioSeat = mss.getStudioSeat();
                com.gen.cinema.domain.Seat seat = studioSeat.getSeat();
                BigDecimal basePrice = mss.getMovieSchedule().getPrice();
                BigDecimal additionalPrice = seat.getAdditionalPrice();
                BigDecimal totalPrice = basePrice.add(additionalPrice != null ? additionalPrice : java.math.BigDecimal.ZERO);
                return new BookingSeatResponse(
                    studioSeat.getId(),
                    studioSeat.getRow(),
                    studioSeat.getNumber(),
                    studioSeat.getXCoordinate(),
                    studioSeat.getYCoordinate(),
                    mss.getStatus().name(),
                    totalPrice,
                    seat.getSeatType().name()
                );
            })
            .collect(Collectors.toList());
        return new BookingScheduleResponse(scheduleId, startTime, seats);
    }
} 