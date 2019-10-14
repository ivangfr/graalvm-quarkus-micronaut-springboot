package com.mycompany.micronautbookapi.service;

import com.mycompany.micronautbookapi.exception.BookNotFoundException;
import com.mycompany.micronautbookapi.model.Book;

public interface BookService {

    Iterable<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);

}
