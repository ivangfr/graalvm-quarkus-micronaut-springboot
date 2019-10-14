package com.mycompany.micronautbookapi.exception;

import io.micronaut.core.annotation.Introspected;

@Introspected
public class BookNotFoundException extends Exception {

    public BookNotFoundException(String message) {
        super(message);
    }
}
