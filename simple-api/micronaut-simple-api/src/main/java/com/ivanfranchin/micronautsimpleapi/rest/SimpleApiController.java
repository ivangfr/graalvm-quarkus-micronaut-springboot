package com.ivanfranchin.micronautsimpleapi.rest;

import com.ivanfranchin.micronautsimpleapi.domain.Greeting;
import com.ivanfranchin.micronautsimpleapi.service.GreetingService;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.QueryValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.validation.constraints.NotBlank;

@Controller("/api/greeting")
public class SimpleApiController {

    private static final Logger LOG = LoggerFactory.getLogger(SimpleApiController.class);

    private final GreetingService greetingService;

    public SimpleApiController(GreetingService greetingService) {
        this.greetingService = greetingService;
    }

    @Get
    public Greeting greetName(@QueryValue(defaultValue = "World") @NotBlank String name) {
        LOG.info("Received request, name: {}", name);
        return greetingService.greet(name);
    }
}
