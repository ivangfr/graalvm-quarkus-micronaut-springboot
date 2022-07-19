package com.ivanfranchin.springbootsimpleapi.service;

import com.ivanfranchin.springbootsimpleapi.domain.Greeting;

public interface GreetingService {

    Greeting greet(String name);
}
