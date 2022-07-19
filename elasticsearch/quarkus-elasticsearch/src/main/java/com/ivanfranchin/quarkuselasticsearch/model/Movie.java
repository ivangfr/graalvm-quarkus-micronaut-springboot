package com.ivanfranchin.quarkuselasticsearch.model;

import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.AllArgsConstructor;
import lombok.Data;

@RegisterForReflection
@Data
@AllArgsConstructor
public class Movie {

    private String imdb;
    private String title;
}
