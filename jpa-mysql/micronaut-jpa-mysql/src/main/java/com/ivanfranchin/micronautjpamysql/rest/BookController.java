package com.ivanfranchin.micronautjpamysql.rest;

import com.ivanfranchin.micronautjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.micronautjpamysql.model.Book;
import com.ivanfranchin.micronautjpamysql.rest.dto.BookResponse;
import com.ivanfranchin.micronautjpamysql.rest.dto.CreateBookRequest;
import com.ivanfranchin.micronautjpamysql.service.BookService;
import io.micronaut.http.HttpStatus;
import io.micronaut.http.annotation.Body;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.Post;
import io.micronaut.http.annotation.Status;
import io.micronaut.scheduling.TaskExecutors;
import io.micronaut.scheduling.annotation.ExecuteOn;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

@Controller("/api/books")
@ExecuteOn(TaskExecutors.IO)
public class BookController {

    private static final Logger log = LoggerFactory.getLogger(BookController.class);

    private final BookService bookService;

    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @Get
    public List<BookResponse> getBooks() {
        log.info("Received request to get all books");
        return bookService.getBooks().stream().map(BookResponse::fromBook).toList();
    }

    @Get("/{id}")
    public BookResponse getBook(Long id) throws BookNotFoundException {
        log.info("Received request to get books with id: {}", id);
        return BookResponse.fromBook(bookService.validateAndGetBook(id));
    }

    @Status(HttpStatus.CREATED)
    @Post
    public BookResponse saveBook(@Valid @Body CreateBookRequest createBookRequest) {
        log.info("Received request to create book: {}", createBookRequest);
        Book book = bookService.saveBook(CreateBookRequest.toBook(createBookRequest));
        return BookResponse.fromBook(book);
    }
}
