package com.mycompany.springbootbookapi.service;

import com.mycompany.springbootbookapi.exception.BookNotFoundException;
import com.mycompany.springbootbookapi.model.Book;

public interface BookService {

    Iterable<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);

}
