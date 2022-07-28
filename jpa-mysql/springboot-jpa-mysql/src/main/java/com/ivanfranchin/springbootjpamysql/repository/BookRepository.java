package com.ivanfranchin.springbootjpamysql.repository;

import com.ivanfranchin.springbootjpamysql.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
}
