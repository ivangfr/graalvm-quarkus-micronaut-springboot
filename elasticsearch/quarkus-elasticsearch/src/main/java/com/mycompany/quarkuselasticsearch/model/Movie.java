package com.mycompany.quarkuselasticsearch.model;

import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.Data;

@RegisterForReflection
@Data
public class Movie {

    private String imdb;
    private String title;

}
