package com.gen.cinema.domain;

import java.util.Set;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "cinema")
public class Cinema extends AbstractBaseEntity {

    @Column(name = "name")
    private String name;

    @Column(name = "address")
    private String address;

    @OneToMany(mappedBy = "cinema")
    private Set<CityCinema> cityCinemas;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Set<CityCinema> getCityCinemas() {
        return cityCinemas;
    }

    public void setCityCinemas(Set<CityCinema> cityCinemas) {
        this.cityCinemas = cityCinemas;
    }
}
