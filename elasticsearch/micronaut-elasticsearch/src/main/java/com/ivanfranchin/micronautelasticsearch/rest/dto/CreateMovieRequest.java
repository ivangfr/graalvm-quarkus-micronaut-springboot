package com.ivanfranchin.micronautelasticsearch.rest.dto;

import io.micronaut.core.annotation.Introspected;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Introspected
@Data
public class CreateMovieRequest {

    @NotBlank
    private String imdb;

    @NotBlank
    private String title;
}
