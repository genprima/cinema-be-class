package com.gen.cinema.domain;

import java.util.Set;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "city")
public class City extends AbstractBaseUUIDEntity {

    @Column(name = "name", nullable = false)
    private String name;

    @OneToMany(mappedBy = "city")
    private Set<CityCinema> cityCinemas;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<CityCinema> getCityCinemas() {
        return cityCinemas;
    }

    public void setCityCinemas(Set<CityCinema> cityCinemas) {
        this.cityCinemas = cityCinemas;
    }
}
