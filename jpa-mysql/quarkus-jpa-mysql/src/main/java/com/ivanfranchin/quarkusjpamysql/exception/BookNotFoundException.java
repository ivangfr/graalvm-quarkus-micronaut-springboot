package com.ivanfranchin.quarkusjpamysql.exception;

public class BookNotFoundException extends Exception {

    public BookNotFoundException(String message) {
        super(message);
    }
}
