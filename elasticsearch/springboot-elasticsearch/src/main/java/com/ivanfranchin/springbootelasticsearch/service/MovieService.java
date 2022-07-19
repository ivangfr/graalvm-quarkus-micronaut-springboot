package com.ivanfranchin.springbootelasticsearch.service;

import com.ivanfranchin.springbootelasticsearch.model.Movie;
import com.ivanfranchin.springbootelasticsearch.rest.dto.SearchMovieResponse;

public interface MovieService {

    String saveMovie(Movie movie);

    SearchMovieResponse searchMovies(String title);
}
