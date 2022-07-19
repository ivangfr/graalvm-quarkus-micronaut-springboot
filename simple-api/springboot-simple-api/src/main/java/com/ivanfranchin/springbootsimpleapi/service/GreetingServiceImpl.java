package com.ivanfranchin.springbootsimpleapi.service;

import com.ivanfranchin.springbootsimpleapi.domain.Greeting;
import org.springframework.stereotype.Service;

@Service
public class GreetingServiceImpl implements GreetingService {

    @Override
    public Greeting greet(String name) {
        String message = String.format("Hello %s!!!", name);
        return new Greeting(message);
    }
}
