package com.ivanfranchin.micronautjpamysql.rest;

import com.ivanfranchin.micronautjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.micronautjpamysql.mapper.BookMapper;
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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@Controller("/api/books")
public class BookController {

    private static final Logger log = LoggerFactory.getLogger(BookController.class);

    private final BookService bookService;
    private final BookMapper bookMapper;

    public BookController(BookService bookService, BookMapper bookMapper) {
        this.bookService = bookService;
        this.bookMapper = bookMapper;
    }

    @Get
    public List<BookResponse> getBooks() {
        log.info("Received request to get all books");
        return bookService.getBooks().stream().map(bookMapper::toBookResponse).collect(Collectors.toList());
    }

    @Get("/{id}")
    public BookResponse getBook(Long id) throws BookNotFoundException {
        log.info("Received request to get books with id: {}", id);
        return bookMapper.toBookResponse(bookService.validateAndGetBook(id));
    }

    @Status(HttpStatus.CREATED)
    @Post
    public BookResponse saveBook(@Valid @Body CreateBookRequest createBookRequest) {
        log.info("Received request to create book: {}", createBookRequest);
        Book book = bookService.saveBook(bookMapper.toBook(createBookRequest));
        return bookMapper.toBookResponse(book);
    }
}
