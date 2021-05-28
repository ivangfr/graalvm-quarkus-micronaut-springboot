package com.mycompany.springbootelasticsearch.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Movie {

    private String imdb;
    private String title;

}
