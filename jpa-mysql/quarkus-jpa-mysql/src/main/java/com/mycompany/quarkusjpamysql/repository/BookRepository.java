package com.mycompany.quarkusjpamysql.repository;

import com.mycompany.quarkusjpamysql.model.Book;
import org.springframework.data.repository.CrudRepository;

public interface BookRepository extends CrudRepository<Book, Long> {
}
