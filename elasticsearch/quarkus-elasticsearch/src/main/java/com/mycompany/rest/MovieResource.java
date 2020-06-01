package com.mycompany.rest;

import com.mycompany.mapper.MovieMapper;
import com.mycompany.model.Movie;
import com.mycompany.rest.dto.CreateMovieRequest;
import com.mycompany.rest.dto.SearchMovieResponse;
import com.mycompany.service.MovieService;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/api/movies")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
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
    public SearchMovieResponse searchMovies(@QueryParam("title") String title) {
        return movieService.searchMovies(title);
    }

}
