package com.ivanfranchin.micronautelasticsearch.rest;

import com.ivanfranchin.micronautelasticsearch.model.Movie;
import com.ivanfranchin.micronautelasticsearch.rest.dto.CreateMovieRequest;
import com.ivanfranchin.micronautelasticsearch.rest.dto.SearchMovieResponse;
import com.ivanfranchin.micronautelasticsearch.service.MovieService;
import io.micronaut.http.HttpStatus;
import io.micronaut.http.annotation.Body;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.Post;
import io.micronaut.http.annotation.QueryValue;
import io.micronaut.http.annotation.Status;
import io.micronaut.scheduling.TaskExecutors;
import io.micronaut.scheduling.annotation.ExecuteOn;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller("/api/movies")
@ExecuteOn(TaskExecutors.IO)
public class MovieController {

    private static final Logger log = LoggerFactory.getLogger(MovieController.class);

    private final MovieService movieService;

    public MovieController(MovieService movieService) {
        this.movieService = movieService;
    }

    @Status(HttpStatus.CREATED)
    @Post
    public String createMovie(@Valid @Body CreateMovieRequest createMovieRequest) {
        log.info("Received request to create movie: {}", createMovieRequest);
        Movie movie = toMovie(createMovieRequest);
        return movieService.saveMovie(movie);
    }

    @Get
    public SearchMovieResponse searchMovies(@QueryValue("title") @NotBlank String title) {
        log.info("Received request to search movies with title: {}", title);
        return movieService.searchMovies(title);
    }

    private Movie toMovie(CreateMovieRequest createMovieRequest) {
        return new Movie(createMovieRequest.imdb(), createMovieRequest.title());
    }
}