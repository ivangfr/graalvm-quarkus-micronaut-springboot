package com.ivanfranchin.springbootjpamysql.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class BookNotFoundException extends Exception {

    public BookNotFoundException(String message) {
        super(message);
    }
}
