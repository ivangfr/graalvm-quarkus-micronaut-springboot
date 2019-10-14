package com.mycompany.micronautbookapi.handler;

import com.mycompany.micronautbookapi.exception.BookNotFoundException;
import io.micronaut.context.annotation.Requires;
import io.micronaut.http.HttpRequest;
import io.micronaut.http.HttpResponse;
import io.micronaut.http.HttpStatus;
import io.micronaut.http.annotation.Produces;
import io.micronaut.http.server.exceptions.ExceptionHandler;

import javax.inject.Singleton;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Produces
@Singleton
@Requires(classes = {BookNotFoundException.class, ExceptionHandler.class})
public class BookNotFoundExceptionHandler implements ExceptionHandler<BookNotFoundException, HttpResponse> {

    @Override
    public HttpResponse handle(HttpRequest request, BookNotFoundException exception) {
        ExceptionDto exceptionDto = new ExceptionDto(
                HttpStatus.NOT_FOUND.getReason(),
                exception.getMessage(),
                request.getPath(),
                HttpStatus.NOT_FOUND.getCode(),
                ZonedDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME)
        );
        return HttpResponse.notFound(exceptionDto);
    }

}
