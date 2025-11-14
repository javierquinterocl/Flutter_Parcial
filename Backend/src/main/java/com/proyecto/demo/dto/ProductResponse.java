package com.proyecto.demo.dto;


import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
public class ProductResponse {
    private Long id;
    private String title;
    private Integer price;
    private String description;
    private List<String> images;
    private String category;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}

