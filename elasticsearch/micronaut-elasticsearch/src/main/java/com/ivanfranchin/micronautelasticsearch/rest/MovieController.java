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

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;

@Controller("/api/movies")
public class MovieController {

    private final MovieService movieService;

    public MovieController(MovieService movieService) {
        this.movieService = movieService;
    }

    @Status(HttpStatus.CREATED)
    @Post
    public String createMovie(@Valid @Body CreateMovieRequest createMovieRequest) {
        Movie movie = toMovie(createMovieRequest);
        return movieService.saveMovie(movie);
    }

    @Get
    public SearchMovieResponse searchMovies(@QueryValue("title") @NotBlank String title) {
        return movieService.searchMovies(title);
    }

    private Movie toMovie(CreateMovieRequest createMovieRequest) {
        return new Movie(createMovieRequest.imdb(), createMovieRequest.title());
    }
}
