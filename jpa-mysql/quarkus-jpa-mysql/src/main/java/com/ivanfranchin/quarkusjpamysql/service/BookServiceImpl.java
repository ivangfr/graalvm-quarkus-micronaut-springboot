package com.ivanfranchin.quarkusjpamysql.service;

import com.ivanfranchin.quarkusjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.quarkusjpamysql.model.Book;
import com.ivanfranchin.quarkusjpamysql.repository.BookRepository;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

@ApplicationScoped
public class BookServiceImpl implements BookService {

    @Inject
    BookRepository bookRepository;

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
