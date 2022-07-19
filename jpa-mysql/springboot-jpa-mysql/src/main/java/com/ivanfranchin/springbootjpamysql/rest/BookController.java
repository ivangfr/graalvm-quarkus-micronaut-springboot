package com.ivanfranchin.springbootjpamysql.rest;

import com.ivanfranchin.springbootjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.springbootjpamysql.mapper.BookMapper;
import com.ivanfranchin.springbootjpamysql.model.Book;
import com.ivanfranchin.springbootjpamysql.rest.dto.CreateBookRequest;
import com.ivanfranchin.springbootjpamysql.service.BookService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@Slf4j
@RestController
@RequestMapping("/api/books")
public class BookController {

    private final BookService bookService;
    private final BookMapper bookMapper;

    public BookController(BookService bookService, BookMapper bookMapper) {
        this.bookService = bookService;
        this.bookMapper = bookMapper;
    }

    @GetMapping
    public Iterable<Book> getBooks() {
        log.info("Received request to get all books");
        return bookService.getBooks();
    }

    @GetMapping("/{id}")
    public Book getBook(@PathVariable Long id) throws BookNotFoundException {
        log.info("Received request to get books with id: {}", id);
        return bookService.validateAndGetBook(id);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping
    public Book createBook(@Valid @RequestBody CreateBookRequest createBookRequest) {
        log.info("Received request to create book: {}", createBookRequest);
        Book book = bookMapper.toBook(createBookRequest);
        return bookService.saveBook(book);
    }
}
