package com.mycompany.quarkuselasticsearch.rest;

import com.mycompany.quarkuselasticsearch.mapper.MovieMapper;
import com.mycompany.quarkuselasticsearch.model.Movie;
import com.mycompany.quarkuselasticsearch.rest.dto.CreateMovieRequest;
import com.mycompany.quarkuselasticsearch.rest.dto.SearchMovieResponse;
import com.mycompany.quarkuselasticsearch.service.MovieService;

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

    @Inject
    MovieMapper movieMapper;

    @POST
    public Response createMovie(@Valid CreateMovieRequest createMovieRequest) {
        Movie movie = movieMapper.toMovie(createMovieRequest);
        String id = movieService.saveMovie(movie);
        return Response.status(Response.Status.CREATED).entity(id).build();
    }

    @GET
    public SearchMovieResponse searchMovies(@QueryParam("title") @NotBlank String title) {
        return movieService.searchMovies(title);
    }
}
