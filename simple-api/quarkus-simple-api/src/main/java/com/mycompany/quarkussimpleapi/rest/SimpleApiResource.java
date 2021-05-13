package com.mycompany.quarkussimpleapi.rest;

import com.mycompany.quarkussimpleapi.domain.Greeting;
import com.mycompany.quarkussimpleapi.service.GreetingService;

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

    private static final Logger LOG = LoggerFactory.getLogger(SimpleApiResource.class);

    @Inject
    GreetingService greetingService;

    @GET
    public Greeting greetName(@QueryParam("name") @DefaultValue("World") @NotBlank String name) {
        LOG.info("Received request, name: {}", name);
        return greetingService.greet(name);
    }
}