package com.ivanfranchin.micronautsimpleapi.service;

import com.ivanfranchin.micronautsimpleapi.domain.Greeting;
import jakarta.inject.Singleton;

@Singleton
public class GreetingServiceImpl implements GreetingService {

    @Override
    public Greeting greet(String name) {
        String message = String.format("Hello %s!!!", name);
        return new Greeting(message);
    }
}
