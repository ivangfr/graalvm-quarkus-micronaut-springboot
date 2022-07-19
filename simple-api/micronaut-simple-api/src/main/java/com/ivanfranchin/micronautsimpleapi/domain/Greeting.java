package com.ivanfranchin.micronautsimpleapi.domain;

import io.micronaut.core.annotation.Introspected;

@Introspected
public class Greeting {

    private String message;

    public Greeting(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
