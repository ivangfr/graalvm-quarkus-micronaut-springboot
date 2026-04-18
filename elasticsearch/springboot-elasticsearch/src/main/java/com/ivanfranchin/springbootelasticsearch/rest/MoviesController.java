package com.ivanfranchin.springbootelasticsearch.rest;

import com.ivanfranchin.springbootelasticsearch.model.Movie;
import com.ivanfranchin.springbootelasticsearch.rest.dto.CreateMovieRequest;
import com.ivanfranchin.springbootelasticsearch.rest.dto.SearchMovieResponse;
import com.ivanfranchin.springbootelasticsearch.service.MovieService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/movies")
public class MoviesController {

    private static final Logger log = LoggerFactory.getLogger(MoviesController.class);

    private final MovieService movieService;

    public MoviesController(MovieService movieService) {
        this.movieService = movieService;
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping
    public String createMovie(@Valid @RequestBody CreateMovieRequest createMovieRequest) {
        log.info("Received request to create movie: {}", createMovieRequest);
        Movie movie = toMovie(createMovieRequest);
        return movieService.saveMovie(movie);
    }

    @GetMapping
    public SearchMovieResponse searchMovies(@RequestParam(value = "title") @NotBlank String title) {
        log.info("Received request to search movies with title: {}", title);
        return movieService.searchMovies(title);
    }

    private Movie toMovie(CreateMovieRequest createMovieRequest) {
        return new Movie(createMovieRequest.imdb(), createMovieRequest.title());
    }
}