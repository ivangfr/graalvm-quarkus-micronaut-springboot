package com.mycompany.micronautjpamysql.repository;

import com.mycompany.micronautjpamysql.model.Book;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.repository.CrudRepository;

@Repository
public interface BookRepository extends CrudRepository<Book, Long> {
}
