package com.ivanfranchin.micronautjpamysql.exception;

import io.micronaut.core.annotation.Introspected;

@Introspected
public class BookNotFoundException extends Exception {

    public BookNotFoundException(String message) {
        super(message);
    }
}
