package com.mycompany.micronautbookapi.rest;

import com.mycompany.micronautbookapi.exception.BookNotFoundException;
import com.mycompany.micronautbookapi.model.Book;
import com.mycompany.micronautbookapi.rest.dto.CreateBookDto;
import com.mycompany.micronautbookapi.service.BookService;
import io.micronaut.http.annotation.Body;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.http.annotation.Post;
import ma.glasnost.orika.MapperFacade;

import javax.validation.Valid;

@Controller("/api/books")
public class BookController {

    private final BookService bookService;
    private final MapperFacade mapperFacade;

    public BookController(BookService bookService, MapperFacade mapperFacade) {
        this.bookService = bookService;
        this.mapperFacade = mapperFacade;
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
        Book book = mapperFacade.map(createBookDto, Book.class);
        return bookService.saveBook(book);
    }

}
