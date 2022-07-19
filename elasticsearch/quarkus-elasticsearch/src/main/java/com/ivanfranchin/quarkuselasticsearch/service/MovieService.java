package com.ivanfranchin.quarkuselasticsearch.service;

import com.ivanfranchin.quarkuselasticsearch.model.Movie;
import com.ivanfranchin.quarkuselasticsearch.rest.dto.SearchMovieResponse;

public interface MovieService {

    String saveMovie(Movie movie);

    SearchMovieResponse searchMovies(String title);
}
