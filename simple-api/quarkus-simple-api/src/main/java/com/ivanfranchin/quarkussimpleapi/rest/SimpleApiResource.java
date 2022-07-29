package com.ivanfranchin.quarkussimpleapi.rest;

import com.ivanfranchin.quarkussimpleapi.domain.Greeting;
import com.ivanfranchin.quarkussimpleapi.service.GreetingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.validation.constraints.NotBlank;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;

@Path("/api/greeting")
public class SimpleApiResource {

    private static final Logger log = LoggerFactory.getLogger(SimpleApiResource.class);

    @Inject
    GreetingService greetingService;

    @GET
    public Greeting greetName(@QueryParam("name") @DefaultValue("World") @NotBlank String name) {
        log.info("Received request, name: {}", name);
        return greetingService.greet(name);
    }
}