package com.ivanfranchin.quarkusjpamysql.repository;

import com.ivanfranchin.quarkusjpamysql.model.Book;
import org.springframework.data.repository.CrudRepository;

public interface BookRepository extends CrudRepository<Book, Long> {
}
