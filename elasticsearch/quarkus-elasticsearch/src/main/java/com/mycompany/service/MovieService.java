package com.mycompany.service;

import com.mycompany.model.Movie;
import com.mycompany.rest.dto.SearchMovieResponse;

public interface MovieService {

    String saveMovie(Movie movie);

    SearchMovieResponse searchMovies(String title);

}
