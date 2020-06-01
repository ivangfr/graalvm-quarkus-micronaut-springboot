package com.mycompany.springbootelasticsearch.rest.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class CreateMovieRequest {

    @NotBlank
    private String imdb;

    @NotBlank
    private String title;

}
