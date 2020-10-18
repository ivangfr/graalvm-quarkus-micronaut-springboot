package com.mycompany.springbootsimpleapi.rest;

import com.mycompany.springbootsimpleapi.domain.Greeting;
import com.mycompany.springbootsimpleapi.service.GreetingService;
// import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

// import javax.validation.constraints.NotBlank;

// @Validated
@RestController
@RequestMapping("/api/greeting")
public class SimpleApiController {

    private final GreetingService greetingService;

    public SimpleApiController(GreetingService greetingService) {
        this.greetingService = greetingService;
    }

    @GetMapping
    //-- The validation @NotBlank is commented because the native image doesn't work with it
    // public Greeting greetName(@RequestParam(defaultValue = "World", required = false) @NotBlank String name) {
    public Greeting greetName(@RequestParam(defaultValue = "World", required = false) String name) {
        return greetingService.greet(name);
    }
}
