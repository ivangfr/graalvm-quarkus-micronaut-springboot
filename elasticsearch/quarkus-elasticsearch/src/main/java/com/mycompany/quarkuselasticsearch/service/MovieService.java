package com.mycompany.quarkuselasticsearch.service;

import com.mycompany.quarkuselasticsearch.model.Movie;
import com.mycompany.quarkuselasticsearch.rest.dto.SearchMovieResponse;

public interface MovieService {

    String saveMovie(Movie movie);

    SearchMovieResponse searchMovies(String title);

}
