package com.ivanfranchin.quarkuselasticsearch.rest;

import com.ivanfranchin.quarkuselasticsearch.model.Movie;
import com.ivanfranchin.quarkuselasticsearch.rest.dto.CreateMovieRequest;
import com.ivanfranchin.quarkuselasticsearch.rest.dto.SearchMovieResponse;
import com.ivanfranchin.quarkuselasticsearch.service.MovieService;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

@Path("/api/movies")
public class MovieResource {

    @Inject
    MovieService movieService;

    @POST
    public Response createMovie(@Valid CreateMovieRequest createMovieRequest) {
        Movie movie = toMovie(createMovieRequest);
        String id = movieService.saveMovie(movie);
        return Response.status(Response.Status.CREATED).entity(id).build();
    }

    @GET
    public SearchMovieResponse searchMovies(@QueryParam("title") @NotBlank String title) {
        return movieService.searchMovies(title);
    }

    private Movie toMovie(CreateMovieRequest createMovieRequest) {
        return new Movie(createMovieRequest.imdb(), createMovieRequest.title());
    }
}
