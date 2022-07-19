package com.ivanfranchin.micronautsimpleapi.service;

import com.ivanfranchin.micronautsimpleapi.domain.Greeting;

public interface GreetingService {

    Greeting greet(String name);
}
