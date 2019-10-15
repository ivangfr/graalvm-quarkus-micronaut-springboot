package com.mycompany.quarkusbookapi.repository;

import com.mycompany.quarkusbookapi.model.Book;
import org.springframework.data.repository.CrudRepository;

public interface BookRepository extends CrudRepository<Book, Long> {
}
