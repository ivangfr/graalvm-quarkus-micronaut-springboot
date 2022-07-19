package com.ivanfranchin.quarkusjpamysql.service;

import com.ivanfranchin.quarkusjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.quarkusjpamysql.model.Book;

public interface BookService {

    Iterable<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);
}
