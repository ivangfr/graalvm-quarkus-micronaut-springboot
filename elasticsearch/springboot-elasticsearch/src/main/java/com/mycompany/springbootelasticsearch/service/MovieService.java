package com.mycompany.springbootelasticsearch.service;

import com.mycompany.springbootelasticsearch.model.Movie;
import com.mycompany.springbootelasticsearch.rest.dto.SearchMovieResponse;

public interface MovieService {

    String saveMovie(Movie movie);

    SearchMovieResponse searchMovies(String title);
}
