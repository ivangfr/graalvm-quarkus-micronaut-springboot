package com.mycompany.micronautbookapi.exception;

// removed @Introspected annotation as suggested in this issue: https://github.com/micronaut-projects/micronaut-core/issues/3240
// @Introspected
public class BookNotFoundException extends Exception {

    public BookNotFoundException(String message) {
        super(message);
    }
}
