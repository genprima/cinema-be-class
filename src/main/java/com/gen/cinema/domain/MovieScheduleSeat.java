package com.gen.cinema.domain;

import com.gen.cinema.enums.SeatStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "movie_schedule_seat")
public class MovieScheduleSeat extends AbstractBaseUUIDEntity {

    @ManyToOne
    @JoinColumn(name = "movie_schedule_id", nullable = false)
    private MovieSchedule movieSchedule;

    @Column(name = "row", nullable = false)
    private String row;

    @Column(name = "number", nullable = false)
    private Integer number;

    @Column(name = "x_coordinate", nullable = false)
    private Double xCoordinate;

    @Column(name = "y_coordinate", nullable = false)
    private Double yCoordinate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private SeatStatus status = SeatStatus.AVAILABLE;

    @Column(name = "price_adjustment")
    private Double priceAdjustment;

    public MovieSchedule getMovieSchedule() {
        return movieSchedule;
    }

    public void setMovieSchedule(MovieSchedule movieSchedule) {
        this.movieSchedule = movieSchedule;
    }

    public String getRow() {
        return row;
    }

    public void setRow(String row) {
        this.row = row;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Double getXCoordinate() {
        return xCoordinate;
    }

    public void setXCoordinate(Double xCoordinate) {
        this.xCoordinate = xCoordinate;
    }

    public Double getYCoordinate() {
        return yCoordinate;
    }

    public void setYCoordinate(Double yCoordinate) {
        this.yCoordinate = yCoordinate;
    }

    public SeatStatus getStatus() {
        return status;
    }

    public void setStatus(SeatStatus status) {
        this.status = status;
    }

    public Double getPriceAdjustment() {
        return priceAdjustment;
    }

    public void setPriceAdjustment(Double priceAdjustment) {
        this.priceAdjustment = priceAdjustment;
    }
} 