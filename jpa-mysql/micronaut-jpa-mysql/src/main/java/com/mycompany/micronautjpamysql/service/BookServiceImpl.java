package com.mycompany.micronautjpamysql.service;

import com.mycompany.micronautjpamysql.exception.BookNotFoundException;
import com.mycompany.micronautjpamysql.model.Book;
import com.mycompany.micronautjpamysql.repository.BookRepository;

import javax.inject.Singleton;

@Singleton
public class BookServiceImpl implements BookService {

    private final BookRepository bookRepository;

    public BookServiceImpl(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    @Override
    public Iterable<Book> getBooks() {
        return bookRepository.findAll();
    }

    @Override
    public Book validateAndGetBook(Long id) throws BookNotFoundException {
        return bookRepository.findById(id)
                .orElseThrow(() -> new BookNotFoundException(String.format("Book with id %s not found", id)));
    }

    @Override
    public Book saveBook(Book book) {
        return bookRepository.save(book);
    }

}
