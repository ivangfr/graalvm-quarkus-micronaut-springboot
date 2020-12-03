package com.mycompany.springbootsimpleapi.rest;

import com.mycompany.springbootsimpleapi.domain.Greeting;
import com.mycompany.springbootsimpleapi.service.GreetingService;
// import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

// import javax.validation.constraints.NotBlank;

// --
// The @Validated annotation is not supported yet in spring-graalvm-native (https://github.com/spring-projects-experimental/spring-graalvm-native/issues/387#issuecomment-737807609).
// It requires https://github.com/spring-projects-experimental/spring-graalvm-native/issues/356 to be supported
// For now, it will be commented out
// --
// @Validated
@RestController
@RequestMapping("/api/greeting")
public class SimpleApiController {

    private final GreetingService greetingService;

    public SimpleApiController(GreetingService greetingService) {
        this.greetingService = greetingService;
    }

    @GetMapping
    //-- Without the @Validated annotation, the @NotBlank annotation won't work. So, it's also commented.
    // public Greeting greetName(@RequestParam(defaultValue = "World", required = false) @NotBlank String name) {
    public Greeting greetName(@RequestParam(defaultValue = "World", required = false) String name) {
        return greetingService.greet(name);
    }
}
