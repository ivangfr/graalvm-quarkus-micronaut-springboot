package com.mycompany.micronautelasticsearch.rest.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.micronaut.core.annotation.Introspected;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Introspected
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SearchMovieResponse {

    private List<Hit> hits;
    private String took;
    private Error error;

    @Introspected
    @Data
    public static class Hit {
        private String index;
        private String id;
        private Float score;
        private String source;
    }

    @Introspected
    @Data
    @AllArgsConstructor
    public static class Error {
        private String message;
    }
}
