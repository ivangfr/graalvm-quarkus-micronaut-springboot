package com.mycompany.springbootjpamysql.repository;

import com.mycompany.springbootjpamysql.model.Book;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends CrudRepository<Book, Long> {
}
