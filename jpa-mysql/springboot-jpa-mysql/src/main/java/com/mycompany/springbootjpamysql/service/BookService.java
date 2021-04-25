package com.mycompany.springbootjpamysql.service;

import com.mycompany.springbootjpamysql.exception.BookNotFoundException;
import com.mycompany.springbootjpamysql.model.Book;

public interface BookService {

    Iterable<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);

}
