package com.ivanfranchin.quarkuselasticsearch.rest.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@JsonInclude(Include.NON_NULL)
public class SearchMovieResponse {

    private List<Hit> hits;
    private String took;
    private Error error;

    @Data
    public static class Hit {
        private String index;
        private String id;
        private Float score;
        private Map<String, ?> source;
    }

    @Data
    @AllArgsConstructor
    public static class Error {
        private String message;
    }
}
