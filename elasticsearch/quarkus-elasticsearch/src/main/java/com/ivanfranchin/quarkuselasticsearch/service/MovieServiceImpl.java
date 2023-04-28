package com.ivanfranchin.quarkuselasticsearch.service;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch._types.FieldValue;
import co.elastic.clients.elasticsearch.core.IndexResponse;
import co.elastic.clients.elasticsearch.core.SearchResponse;
import co.elastic.clients.elasticsearch.core.search.Hit;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ivanfranchin.quarkuselasticsearch.exception.MovieServiceException;
import com.ivanfranchin.quarkuselasticsearch.model.Movie;
import com.ivanfranchin.quarkuselasticsearch.rest.dto.SearchMovieResponse;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

@ApplicationScoped
public class MovieServiceImpl implements MovieService {

    private static final Logger log = LoggerFactory.getLogger(MovieServiceImpl.class);

    @Inject
    ElasticsearchClient client;

    @Inject
    ObjectMapper mapper;

    @ConfigProperty(name = "elasticsearch.indexes.movies")
    String moviesIndex;

    @Override
    public String saveMovie(Movie movie) {
        try {
            IndexResponse indexResponse = client.index(IndexRequestBuilder -> IndexRequestBuilder
                    .index(moviesIndex)
                    .document(movie));
            String id = indexResponse.id();
            log.info("Document for '{}' {} successfully in ES. The id is: {}", movie, indexResponse.result(), id);
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
            SearchResponse<Movie> searchResponse = client.search(SearchRequestBuilder -> SearchRequestBuilder
                            .index(moviesIndex)
                            .query(QueryBuilder -> QueryBuilder
                                    .term(TermQueryBuilder -> TermQueryBuilder
                                            .field("title").value(FieldValue.of(title)))),
                    Movie.class);
            List<Hit<Movie>> hits = searchResponse.hits().hits();
            log.info("Searching for '{}' took {} and found {}", title, searchResponse.took(), hits.size());
            return toSearchMovieResponse(hits, searchResponse.took());
        } catch (Exception e) {
            String errorMessage = String.format("An exception occurred while searching for title '%s'. %s", title, e.getMessage());
            log.error(errorMessage);
            return createSearchMovieResponseError(errorMessage);
        }
    }

    private SearchMovieResponse toSearchMovieResponse(List<Hit<Movie>> hits, long took) {
        List<SearchMovieResponse.MovieHit> movieHits = hits.stream()
                .map(hit -> new SearchMovieResponse.MovieHit(hit.index(), hit.id(), hit.score(), hit.source()))
                .toList();
        return new SearchMovieResponse(movieHits, took);
    }

    private SearchMovieResponse createSearchMovieResponseError(String errorMessage) {
        return new SearchMovieResponse(new SearchMovieResponse.Error(errorMessage));
    }
}
