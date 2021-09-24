package com.mycompany.micronautelasticsearch.model;

import io.micronaut.core.annotation.Introspected;
import lombok.AllArgsConstructor;
import lombok.Data;

@Introspected
@Data
@AllArgsConstructor
public class Movie {

    private String imdb;
    private String title;
}
