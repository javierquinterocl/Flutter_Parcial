package com.proyecto.demo.dto;

import lombok.Data;

import java.util.List;

@Data

public class ProductRequest {
    private String title;
    private Integer price;
    private String description;
    private List<String> images;
    private String category;
}

