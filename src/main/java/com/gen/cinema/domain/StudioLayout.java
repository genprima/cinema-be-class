package com.gen.cinema.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "studio_layout")
public class StudioLayout extends AbstractBaseEntity {

    @Column(name = "name")
    private String name;

    @Column(name = "max_rows")
    private Integer maxRows;

    @Column(name = "max_columns")
    private Integer maxColumns;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getMaxRows() {
        return maxRows;
    }

    public void setMaxRows(Integer maxRows) {
        this.maxRows = maxRows;
    }

    public Integer getMaxColumns() {
        return maxColumns;
    }

    public void setMaxColumns(Integer maxColumns) {
        this.maxColumns = maxColumns;
    }
    
}
