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
    private String maxRows;

    @Column(name = "max_columns")
    private String maxColumns;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMaxRows() {
        return maxRows;
    }

    public void setMaxRows(String maxRows) {
        this.maxRows = maxRows;
    }

    public String getMaxColumns() {
        return maxColumns;
    }

    public void setMaxColumns(String maxColumns) {
        this.maxColumns = maxColumns;
    }
    
}
