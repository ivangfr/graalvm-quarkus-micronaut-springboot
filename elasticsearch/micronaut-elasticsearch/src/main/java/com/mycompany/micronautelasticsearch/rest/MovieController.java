package com.mycompany.micronautelasticsearch.rest;

import com.mycompany.micronautelasticsearch.mapper.MovieMapper;
import com.mycompany.micronautelasticsearch.model.Movie;
import com.mycompany.micronautelasticsearch.rest.dto.CreateMovieRequest;
import com.mycompany.micronautelasticsearch.rest.dto.SearchMovieResponse;
import com.mycompany.micronautelasticsearch.service.MovieService;
import io.micronaut.http.HttpStatus;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.Post;
import io.micronaut.http.annotation.QueryValue;
import io.micronaut.http.annotation.Status;

import javax.validation.Valid;

@Controller("/api/movies")
public class MovieController {

    private final MovieService movieService;
    private final MovieMapper movieMapper;

    public MovieController(MovieService movieService, MovieMapper movieMapper) {
        this.movieService = movieService;
        this.movieMapper = movieMapper;
    }

    @Status(HttpStatus.CREATED)
    @Post
    public String createMovie(@Valid CreateMovieRequest createMovieRequest) {
        Movie movie = movieMapper.toMovie(createMovieRequest);
        return movieService.saveMovie(movie);
    }

    @Get
    public SearchMovieResponse searchMovies(@QueryValue("title") String title) {
        return movieService.searchMovies(title);
    }

}
