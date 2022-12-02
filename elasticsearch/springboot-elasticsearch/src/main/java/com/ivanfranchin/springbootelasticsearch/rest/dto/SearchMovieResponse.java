package com.ivanfranchin.springbootelasticsearch.rest.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.ivanfranchin.springbootelasticsearch.model.Movie;

import java.util.List;

@JsonInclude(Include.NON_NULL)
public record SearchMovieResponse(List<MovieHit> movieHits, long took, Error error) {

    public SearchMovieResponse(List<MovieHit> movieHits, long took) {
        this(movieHits, took, null);
    }

    public SearchMovieResponse(Error error) {
        this(null, 0, error);
    }

    public record MovieHit(String index, String id, Double score, Movie source) {
    }

    public record Error(String message) {
    }
}
