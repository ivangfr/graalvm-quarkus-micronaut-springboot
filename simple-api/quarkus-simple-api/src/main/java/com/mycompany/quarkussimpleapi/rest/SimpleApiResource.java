package com.mycompany.quarkussimpleapi.rest;

import com.mycompany.quarkussimpleapi.domain.Greeting;
import com.mycompany.quarkussimpleapi.service.GreetingService;

import javax.inject.Inject;
import javax.validation.constraints.NotBlank;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;

@Path("/api/greeting")
public class SimpleApiResource {

    @Inject
    GreetingService greetingService;

    @GET
    public Greeting greetName(@QueryParam("name") @DefaultValue("World") @NotBlank String name) {
        return greetingService.greet(name);
    }
}