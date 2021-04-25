package com.mycompany.quarkusjpamysql.service;

import com.mycompany.quarkusjpamysql.exception.BookNotFoundException;
import com.mycompany.quarkusjpamysql.model.Book;

public interface BookService {

    Iterable<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);

}
