package com.mycompany.micronautbookapi.service;

import com.mycompany.micronautbookapi.exception.BookNotFoundException;
import com.mycompany.micronautbookapi.model.Book;
import com.mycompany.micronautbookapi.repository.BookRepository;

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
