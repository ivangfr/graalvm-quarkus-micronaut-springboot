package com.ivanfranchin.micronautjpamysql.service;

import com.ivanfranchin.micronautjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.micronautjpamysql.model.Book;

public interface BookService {

    Iterable<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);
}
