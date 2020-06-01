package com.mycompany.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.exception.MovieServiceException;
import com.mycompany.mapper.MovieMapper;
import com.mycompany.model.Movie;
import com.mycompany.rest.dto.SearchMovieResponse;
import io.micronaut.context.annotation.Value;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.builder.SearchSourceBuilder;

import javax.inject.Singleton;

@Slf4j
@Singleton
public class MovieServiceImpl implements MovieService {

    @Value("${elasticsearch.indexes.movies}")
    String moviesIndex;

    private final RestHighLevelClient client;
    private final MovieMapper movieMapper;
    private final ObjectMapper objectMapper;

    public MovieServiceImpl(RestHighLevelClient client, MovieMapper movieMapper, ObjectMapper objectMapper) {
        this.client = client;
        this.movieMapper = movieMapper;
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
            String errorMessage = String.format("An exception occurred while indexing '%s'", movie);
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
            return movieMapper.toSearchMovieDto(searchResponse.getHits(), searchResponse.getTook());
        } catch (Exception e) {
            String errorMessage = String.format("An exception occurred while searching for title '%s'", title);
            log.error(errorMessage);
            throw new MovieServiceException(errorMessage, e);
        }
    }
}
