package com.ivanfranchin.micronautelasticsearch.rest.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.ivanfranchin.micronautelasticsearch.model.Movie;
import io.micronaut.core.annotation.Introspected;

import java.util.List;

@Introspected
@JsonInclude(Include.NON_NULL)
public record SearchMovieResponse(List<MovieHit> movieHits, long took, Error error) {

    public SearchMovieResponse(List<MovieHit> movieHits, long took) {
        this(movieHits, took, null);
    }

    public SearchMovieResponse(Error error) {
        this(null, 0, error);
    }

    @Introspected
    public record MovieHit(String index, String id, Double score, Movie source) {
    }

    @Introspected
    public record Error(String message) {
    }
}
