package com.gen.cinema.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "cinema")
public class Cinema extends AbstractBaseEntity {

    @Column(name = "name")
    private String name;

    @Column(name = "address")
    private String address;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }
    
    
}
