package com.ivanfranchin.quarkuselasticsearch.rest.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import java.util.List;
import java.util.Map;

@JsonInclude(Include.NON_NULL)
public record SearchMovieResponse(List<Hit> hits, String took, Error error) {

    public SearchMovieResponse(List<Hit> hits, String took) {
        this(hits, took, null);
    }

    public SearchMovieResponse(Error error) {
        this(null, null, error);
    }

    public record Hit(String index, String id, Float score, Map<String, ?> source) {
    }

    public record Error(String message) {
    }
}
