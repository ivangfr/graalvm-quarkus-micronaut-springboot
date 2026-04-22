package com.ivanfranchin.springbootjpamysql.rest;

import com.ivanfranchin.springbootjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.springbootjpamysql.model.Book;
import com.ivanfranchin.springbootjpamysql.rest.dto.BookResponse;
import com.ivanfranchin.springbootjpamysql.rest.dto.CreateBookRequest;
import com.ivanfranchin.springbootjpamysql.service.BookService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/books")
public class BookController {

    private static final Logger log = LoggerFactory.getLogger(BookController.class);

    private final BookService bookService;

    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping
    public List<BookResponse> getBooks() {
        log.info("Received request to get all books. Processed by {}", Thread.currentThread());
        return bookService.getBooks().stream().map(BookResponse::fromBook).toList();
    }

    @GetMapping("/{id}")
    public BookResponse getBook(@PathVariable Long id) throws BookNotFoundException {
        log.info("Received request to get books with id: {}. Processed by {}", id, Thread.currentThread());
        return BookResponse.fromBook(bookService.validateAndGetBook(id));
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping
    public BookResponse createBook(@Valid @RequestBody CreateBookRequest createBookRequest) {
        log.info("Received request to create book: {}. Processed by {}", createBookRequest, Thread.currentThread());
        Book book = bookService.saveBook(CreateBookRequest.toBook(createBookRequest));
        return BookResponse.fromBook(book);
    }
}
