package com.gen.cinema.web;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gen.cinema.dto.response.BookingScheduleResponse;
import com.gen.cinema.service.BookingService;

@RestController
@RequestMapping("/v1/booking")
public class BookingController {

    private final BookingService bookingService;

    public BookingController(BookingService bookingService) {
        this.bookingService = bookingService;
    }

    @GetMapping("/schedule")
    public ResponseEntity<BookingScheduleResponse> getScheduleSeats(
            @RequestParam("schedule_id") String scheduleId) {
        return ResponseEntity.ok(bookingService.getScheduleSeats(scheduleId));
    }
} 