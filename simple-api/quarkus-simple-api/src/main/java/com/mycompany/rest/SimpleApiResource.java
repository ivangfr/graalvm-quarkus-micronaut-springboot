package com.mycompany.rest;

import com.mycompany.domain.Greeting;
import com.mycompany.service.GreetingService;

import javax.inject.Inject;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

@Path("/api/greeting")
public class SimpleApiResource {

    @Inject
    GreetingService greetingService;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Greeting greetName(@QueryParam("name") @DefaultValue("World") String name) {
        return greetingService.greet(name);
    }
}