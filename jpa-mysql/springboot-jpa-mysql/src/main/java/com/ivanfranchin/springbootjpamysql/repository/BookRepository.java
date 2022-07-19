package com.ivanfranchin.springbootjpamysql.repository;

import com.ivanfranchin.springbootjpamysql.model.Book;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends CrudRepository<Book, Long> {
}
