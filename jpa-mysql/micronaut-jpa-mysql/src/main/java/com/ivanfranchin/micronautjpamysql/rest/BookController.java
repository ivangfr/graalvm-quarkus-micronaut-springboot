package com.ivanfranchin.micronautjpamysql.rest;

import com.ivanfranchin.micronautjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.micronautjpamysql.mapper.BookMapper;
import com.ivanfranchin.micronautjpamysql.model.Book;
import com.ivanfranchin.micronautjpamysql.rest.dto.CreateBookRequest;
import com.ivanfranchin.micronautjpamysql.service.BookService;
import io.micronaut.http.HttpStatus;
import io.micronaut.http.annotation.Body;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.Post;
import io.micronaut.http.annotation.Status;
import lombok.extern.slf4j.Slf4j;

import javax.validation.Valid;

@Slf4j
@Controller("/api/books")
public class BookController {

    private final BookService bookService;
    private final BookMapper bookMapper;

    public BookController(BookService bookService, BookMapper bookMapper) {
        this.bookService = bookService;
        this.bookMapper = bookMapper;
    }

    @Get
    public Iterable<Book> getBooks() {
        log.info("Received request to get all books");
        return bookService.getBooks();
    }

    @Get("/{id}")
    public Book getBook(Long id) throws BookNotFoundException {
        log.info("Received request to get books with id: {}", id);
        return bookService.validateAndGetBook(id);
    }

    @Status(HttpStatus.CREATED)
    @Post
    public Book saveBook(@Valid @Body CreateBookRequest createBookRequest) {
        log.info("Received request to create book: {}", createBookRequest);
        Book book = bookMapper.toBook(createBookRequest);
        return bookService.saveBook(book);
    }
}
