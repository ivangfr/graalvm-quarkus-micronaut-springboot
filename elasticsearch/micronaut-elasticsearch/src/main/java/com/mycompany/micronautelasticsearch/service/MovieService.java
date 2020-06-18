package com.mycompany.micronautelasticsearch.service;

import com.mycompany.micronautelasticsearch.model.Movie;
import com.mycompany.micronautelasticsearch.rest.dto.SearchMovieResponse;

public interface MovieService {

    String saveMovie(Movie movie);

    SearchMovieResponse searchMovies(String title);

}
