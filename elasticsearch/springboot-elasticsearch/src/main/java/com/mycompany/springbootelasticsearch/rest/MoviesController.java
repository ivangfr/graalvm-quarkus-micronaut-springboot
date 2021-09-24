package com.mycompany.springbootelasticsearch.rest;

import com.mycompany.springbootelasticsearch.model.Movie;
import com.mycompany.springbootelasticsearch.rest.dto.CreateMovieRequest;
import com.mycompany.springbootelasticsearch.rest.dto.SearchMovieResponse;
import com.mycompany.springbootelasticsearch.service.MovieService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;

@RestController
@RequestMapping("/api/movies")
public class MoviesController {

    private final MovieService movieService;

    public MoviesController(MovieService movieService) {
        this.movieService = movieService;
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping
    public String createMovie(@Valid @RequestBody CreateMovieRequest createMovieRequest) {
        Movie movie = toMovie(createMovieRequest);
        return movieService.saveMovie(movie);
    }

    @GetMapping
    public SearchMovieResponse searchMovies(@RequestParam(value = "title") @NotBlank String title) {
        return movieService.searchMovies(title);
    }

    private Movie toMovie(CreateMovieRequest createMovieRequest) {
        return new Movie(createMovieRequest.getImdb(), createMovieRequest.getTitle());
    }
}
