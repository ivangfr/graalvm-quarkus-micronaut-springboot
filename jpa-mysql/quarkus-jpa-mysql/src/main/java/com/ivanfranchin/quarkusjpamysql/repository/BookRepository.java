package com.ivanfranchin.quarkusjpamysql.repository;

import com.ivanfranchin.quarkusjpamysql.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookRepository extends JpaRepository<Book, Long> {
}
