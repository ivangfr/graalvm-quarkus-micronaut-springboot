package com.mycompany.springbootelasticsearch.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.springbootelasticsearch.exception.MovieServiceException;
import com.mycompany.springbootelasticsearch.model.Movie;
import com.mycompany.springbootelasticsearch.rest.dto.SearchMovieResponse;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.core.TimeValue;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.xcontent.XContentType;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class MovieServiceImpl implements MovieService {

    @Value("${elasticsearch.indexes.movies}")
    private String moviesIndex;

    private final RestHighLevelClient client;
    private final ObjectMapper objectMapper;

    public MovieServiceImpl(RestHighLevelClient client, ObjectMapper objectMapper) {
        this.client = client;
        this.objectMapper = objectMapper;
    }

    @Override
    public String saveMovie(Movie movie) {
        try {
            String movieAsJsonString = objectMapper.writeValueAsString(movie);
            IndexRequest indexRequest = new IndexRequest(moviesIndex).source(movieAsJsonString, XContentType.JSON);
            IndexResponse indexResponse = client.index(indexRequest, RequestOptions.DEFAULT);
            String id = indexResponse.getId();
            log.info("Document for '{}' {} successfully in ES. The id is: {}", movie, indexResponse.getResult(), id);
            return id;
        } catch (Exception e) {
            String errorMessage = String.format("An exception occurred while indexing '%s'. %s", movie, e.getMessage());
            log.error(errorMessage);
            throw new MovieServiceException(errorMessage, e);
        }
    }

    @Override
    public SearchMovieResponse searchMovies(String title) {
        try {
            SearchRequest searchRequest = new SearchRequest(moviesIndex);
            SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
            searchSourceBuilder.query(QueryBuilders.termQuery("title", title));
            searchRequest.source(searchSourceBuilder);
            SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
            log.info("Searching for '{}' took {} and found {}", title, searchResponse.getTook(), searchResponse.getHits().getTotalHits());
            return toSearchMovieResponse(searchResponse.getHits(), searchResponse.getTook());
        } catch (Exception e) {
            String errorMessage = String.format("An exception occurred while searching for title '%s'. %s", title, e.getMessage());
            log.error(errorMessage);
            return createSearchMovieResponseError(errorMessage);
        }
    }

    private SearchMovieResponse toSearchMovieResponse(SearchHits searchHits, TimeValue took) {
        SearchMovieResponse searchMovieResponse = new SearchMovieResponse();
        List<SearchMovieResponse.Hit> hits = new ArrayList<>();
        for (SearchHit searchHit : searchHits.getHits()) {
            SearchMovieResponse.Hit hit = new SearchMovieResponse.Hit();
            hit.setIndex(searchHit.getIndex());
            hit.setId(searchHit.getId());
            hit.setScore(searchHit.getScore());
            hit.setSource(searchHit.getSourceAsString());
            hits.add(hit);
        }
        searchMovieResponse.setHits(hits);
        searchMovieResponse.setTook(took.toString());
        return searchMovieResponse;
    }

    private SearchMovieResponse createSearchMovieResponseError(String errorMessage) {
        SearchMovieResponse searchMovieResponse = new SearchMovieResponse();
        searchMovieResponse.setError(new SearchMovieResponse.Error(errorMessage));
        return searchMovieResponse;
    }
}
