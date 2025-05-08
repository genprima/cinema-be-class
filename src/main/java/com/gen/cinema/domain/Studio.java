package com.gen.cinema.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "studio")
public class Studio extends AbstractBaseEntity {

    @Column(name = "name")
    private String name;

    @ManyToOne
    @JoinColumn(name = "city_cinema_id")
    private CityCinema cityCinema;

    @ManyToOne
    @JoinColumn(name = "studio_layout_id")
    private StudioLayout studioLayout;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public CityCinema getCityCinema() {
        return cityCinema;
    }

    public void setCityCinema(CityCinema cityCinema) {
        this.cityCinema = cityCinema;
    }

    public StudioLayout getStudioLayout() {
        return studioLayout;
    }

    public void setStudioLayout(StudioLayout studioLayout) {
        this.studioLayout = studioLayout;
    }
}
