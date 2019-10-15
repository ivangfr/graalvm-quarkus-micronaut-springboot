package com.mycompany.quarkusbookapi.service;

import com.mycompany.quarkusbookapi.exception.BookNotFoundException;
import com.mycompany.quarkusbookapi.model.Book;

public interface BookService {

    Iterable<Book> getBooks();

    Book validateAndGetBook(Long id) throws BookNotFoundException;

    Book saveBook(Book book);

}
