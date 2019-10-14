package com.mycompany.springbootbookapi.rest;

import com.mycompany.springbootbookapi.exception.BookNotFoundException;
import com.mycompany.springbootbookapi.model.Book;
import com.mycompany.springbootbookapi.rest.dto.CreateBookDto;
import com.mycompany.springbootbookapi.service.BookService;
import ma.glasnost.orika.MapperFacade;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@RestController
@RequestMapping("/api/books")
public class BookController {

    private final BookService bookService;
    private final MapperFacade mapperFacade;

    public BookController(BookService bookService, MapperFacade mapperFacade) {
        this.bookService = bookService;
        this.mapperFacade = mapperFacade;
    }

    @GetMapping
    public Iterable<Book> getBooks() {
        return bookService.getBooks();
    }

    @GetMapping("/{id}")
    public Book getBook(@PathVariable Long id) throws BookNotFoundException {
        return bookService.validateAndGetBook(id);
    }

    @PostMapping
    public Book createBook(@Valid @RequestBody CreateBookDto createBookDto) {
        Book book = mapperFacade.map(createBookDto, Book.class);
        return bookService.saveBook(book);
    }

}
