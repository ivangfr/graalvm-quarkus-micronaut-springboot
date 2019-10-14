package com.mycompany.service;

import com.mycompany.exception.BookNotFoundException;
import com.mycompany.model.Book;

public interface BookService {

    Iterable<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);

}
