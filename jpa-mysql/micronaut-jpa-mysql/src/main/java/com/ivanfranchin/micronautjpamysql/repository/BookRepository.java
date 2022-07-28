package com.ivanfranchin.micronautjpamysql.repository;

import com.ivanfranchin.micronautjpamysql.model.Book;
import io.micronaut.data.annotation.Repository;
import io.micronaut.data.jpa.repository.JpaRepository;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
}
