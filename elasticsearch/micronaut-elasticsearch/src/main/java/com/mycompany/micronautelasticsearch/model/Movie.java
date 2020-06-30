package com.mycompany.micronautelasticsearch.model;

import io.micronaut.core.annotation.Introspected;
import lombok.Data;

@Introspected
@Data
public class Movie {

    private String imdb;
    private String title;

}
