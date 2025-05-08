package com.gen.cinema.domain;

import java.math.BigDecimal;

import com.gen.cinema.enums.SeatType;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;

@Entity
@Table(name = "seat")
public class Seat extends AbstractBaseEntity {

    @Column(name = "row")
    private String row;

    @Column(name = "number")
    private Integer number;

    @Column(columnDefinition = "varchar(255)")
    @Enumerated(EnumType.STRING)
    private SeatType seatType;

    @Column(name = "additional_price")
    private BigDecimal additionalPrice;

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
}
