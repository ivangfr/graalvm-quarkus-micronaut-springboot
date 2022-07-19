package com.ivanfranchin.springbootjpamysql.service;

import com.ivanfranchin.springbootjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.springbootjpamysql.model.Book;

public interface BookService {

    Iterable<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);
}
