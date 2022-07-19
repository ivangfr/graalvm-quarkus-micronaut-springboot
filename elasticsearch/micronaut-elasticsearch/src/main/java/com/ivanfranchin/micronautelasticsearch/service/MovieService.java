package com.ivanfranchin.micronautelasticsearch.service;

import com.ivanfranchin.micronautelasticsearch.model.Movie;
import com.ivanfranchin.micronautelasticsearch.rest.dto.SearchMovieResponse;

public interface MovieService {

    String saveMovie(Movie movie);

    SearchMovieResponse searchMovies(String title);
}
