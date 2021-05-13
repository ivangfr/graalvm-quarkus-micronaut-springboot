package com.mycompany.springbootjpamysql.rest;

import com.mycompany.springbootjpamysql.exception.BookNotFoundException;
import com.mycompany.springbootjpamysql.mapper.BookMapper;
import com.mycompany.springbootjpamysql.model.Book;
import com.mycompany.springbootjpamysql.rest.dto.CreateBookDto;
import com.mycompany.springbootjpamysql.service.BookService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;

// import javax.validation.Valid;

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
    //public Book createBook(@Valid @RequestBody CreateBookDto createBookDto) {
    public Book createBook(@RequestBody CreateBookDto createBookDto) {
        log.info("Received request to create book: {}", createBookDto);
        Book book = bookMapper.toBook(createBookDto);
        return bookService.saveBook(book);
    }

}
