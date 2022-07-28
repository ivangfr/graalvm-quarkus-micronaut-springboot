package com.ivanfranchin.springbootjpamysql.service;

import com.ivanfranchin.springbootjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.springbootjpamysql.model.Book;

import java.util.List;

public interface BookService {

    List<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);
}
