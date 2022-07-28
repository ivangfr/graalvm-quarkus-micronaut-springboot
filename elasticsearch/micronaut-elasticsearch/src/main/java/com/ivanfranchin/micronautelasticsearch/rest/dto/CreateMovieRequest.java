package com.ivanfranchin.micronautelasticsearch.rest.dto;

import io.micronaut.core.annotation.Introspected;

import javax.validation.constraints.NotBlank;

@Introspected
public record CreateMovieRequest(@NotBlank String imdb, @NotBlank String title) {
}
