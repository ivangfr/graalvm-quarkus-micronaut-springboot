package com.mycompany.springbootbookapi.repository;

import com.mycompany.springbootbookapi.model.Book;
import org.springframework.data.repository.CrudRepository;

public interface BookRepository extends CrudRepository<Book, Long> {
}
