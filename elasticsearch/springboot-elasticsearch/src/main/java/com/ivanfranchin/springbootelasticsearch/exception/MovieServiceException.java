package com.ivanfranchin.springbootelasticsearch.exception;

public class MovieServiceException extends RuntimeException {

    public MovieServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}
