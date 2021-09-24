package com.mycompany.quarkussimpleapi.service;

import com.mycompany.quarkussimpleapi.domain.Greeting;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class GreetingServiceImpl implements GreetingService {

    @Override
    public Greeting greet(String name) {
        String message = String.format("Hello %s!!!", name);
        return new Greeting(message);
    }
}
