package com.mycompany.micronautsimpleapi.service;

import com.mycompany.micronautsimpleapi.domain.Greeting;

import javax.inject.Singleton;

@Singleton
public class GreetingServiceImpl implements GreetingService {

    @Override
    public Greeting greet(String name) {
        String message = String.format("Hello %s!!!", name);
        return new Greeting(message);
    }

}
