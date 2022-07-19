package com.ivanfranchin.micronautjpamysql.repository;

import com.ivanfranchin.micronautjpamysql.model.Book;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.repository.CrudRepository;

@Repository
public interface BookRepository extends CrudRepository<Book, Long> {
}
