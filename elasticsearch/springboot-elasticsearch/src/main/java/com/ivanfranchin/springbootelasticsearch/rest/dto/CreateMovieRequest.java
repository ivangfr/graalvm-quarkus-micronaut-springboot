package com.ivanfranchin.springbootelasticsearch.rest.dto;

import javax.validation.constraints.NotBlank;

public record CreateMovieRequest(@NotBlank String imdb, @NotBlank String title) {
}
