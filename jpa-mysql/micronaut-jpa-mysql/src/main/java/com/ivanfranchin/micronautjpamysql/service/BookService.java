package com.ivanfranchin.micronautjpamysql.service;

import com.ivanfranchin.micronautjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.micronautjpamysql.model.Book;

import java.util.List;

public interface BookService {

    List<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);
}
