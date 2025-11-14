package com.proyecto.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;

@Configuration
public class CorsConfig {

    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        CorsConfiguration config = new CorsConfiguration();
        
        // Permitir todos los orígenes (para desarrollo)
        config.setAllowCredentials(true);
        config.addAllowedOriginPattern("*");
        
        // Permitir todos los métodos HTTP
        config.addAllowedMethod("*");
        
        // Permitir todos los headers
        config.addAllowedHeader("*");
        
        // Exponer headers específicos si es necesario
        config.addExposedHeader("*");
        
        source.registerCorsConfiguration("/**", config);
        return new CorsFilter(source);
    }
}

