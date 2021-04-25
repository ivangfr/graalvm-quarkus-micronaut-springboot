package com.mycompany.springbootjpamysql.repository;

import com.mycompany.springbootjpamysql.model.Book;
import org.springframework.data.repository.CrudRepository;

public interface BookRepository extends CrudRepository<Book, Long> {
}
