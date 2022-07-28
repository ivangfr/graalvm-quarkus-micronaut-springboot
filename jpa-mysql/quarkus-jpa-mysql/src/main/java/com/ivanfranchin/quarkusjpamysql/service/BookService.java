package com.ivanfranchin.quarkusjpamysql.service;

import com.ivanfranchin.quarkusjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.quarkusjpamysql.model.Book;

import java.util.List;

public interface BookService {

    List<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);
}
