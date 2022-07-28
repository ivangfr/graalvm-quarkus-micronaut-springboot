package com.ivanfranchin.micronautelasticsearch.rest.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import io.micronaut.core.annotation.Introspected;

import java.util.List;
import java.util.Map;

@Introspected
@JsonInclude(Include.NON_NULL)
public record SearchMovieResponse(List<Hit> hits, String took, Error error) {

    public SearchMovieResponse(List<Hit> hits, String took) {
        this(hits, took, null);
    }

    public SearchMovieResponse(Error error) {
        this(null, null, error);
    }

    @Introspected
    public record Hit(String index, String id, Float score, Map<String, ?> source) {
    }

    @Introspected
    public record Error(String message) {
    }
}
