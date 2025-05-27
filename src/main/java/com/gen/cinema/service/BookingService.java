package com.gen.cinema.service;

import com.gen.cinema.dto.response.BookingScheduleResponse;
 
public interface BookingService {
    BookingScheduleResponse getScheduleSeats(String scheduleId);
} 