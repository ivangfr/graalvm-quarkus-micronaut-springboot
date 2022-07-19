package com.ivanfranchin.quarkussimpleapi.service;

import com.ivanfranchin.quarkussimpleapi.domain.Greeting;

public interface GreetingService {

    Greeting greet(String name);
}
