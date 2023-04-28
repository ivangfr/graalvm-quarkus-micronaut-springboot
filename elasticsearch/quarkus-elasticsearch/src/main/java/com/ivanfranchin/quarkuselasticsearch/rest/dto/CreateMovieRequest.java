package com.ivanfranchin.quarkuselasticsearch.rest.dto;

import jakarta.validation.constraints.NotBlank;

public record CreateMovieRequest(@NotBlank String imdb, @NotBlank String title) {
}
