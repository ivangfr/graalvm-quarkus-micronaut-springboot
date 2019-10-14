package com.mycompany.springbootsimpleapi.rest;

import com.mycompany.springbootsimpleapi.domain.Greeting;
import com.mycompany.springbootsimpleapi.service.GreetingService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/greeting")
public class SimpleApiController {

    private final GreetingService greetingService;

    public SimpleApiController(GreetingService greetingService) {
        this.greetingService = greetingService;
    }

    @GetMapping
    public Greeting greetName(@RequestParam(defaultValue = "World") String name) {
        return greetingService.greet(name+"-Ivan");
    }

}
