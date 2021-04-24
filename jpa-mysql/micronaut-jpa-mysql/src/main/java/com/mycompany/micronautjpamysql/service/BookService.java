package com.mycompany.micronautjpamysql.service;

import com.mycompany.micronautjpamysql.exception.BookNotFoundException;
import com.mycompany.micronautjpamysql.model.Book;

public interface BookService {

    Iterable<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);

}
