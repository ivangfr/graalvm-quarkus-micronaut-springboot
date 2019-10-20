package com.mycompany.micronautbookapi.rest;

import com.mycompany.micronautbookapi.exception.BookNotFoundException;
import com.mycompany.micronautbookapi.mapper.BookMapper;
import com.mycompany.micronautbookapi.model.Book;
import com.mycompany.micronautbookapi.rest.dto.CreateBookDto;
import com.mycompany.micronautbookapi.service.BookService;
import io.micronaut.http.annotation.Body;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.Post;

import javax.validation.Valid;

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
        return bookService.getBooks();
    }

    @Get("/{id}")
    public Book getBook(Long id) throws BookNotFoundException {
        return bookService.validateAndGetBook(id);
    }

    @Post
    public Book saveBook(@Valid @Body CreateBookDto createBookDto) {
        Book book = bookMapper.toBook(createBookDto);
        return bookService.saveBook(book);
    }

}
