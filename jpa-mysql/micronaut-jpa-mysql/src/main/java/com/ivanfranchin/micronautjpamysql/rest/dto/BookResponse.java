package com.ivanfranchin.micronautjpamysql.rest.dto;

import com.ivanfranchin.micronautjpamysql.model.Book;
import io.micronaut.core.annotation.Introspected;

@Introspected
public record BookResponse(String id, String isbn, String title) {

    public static BookResponse fromBook(Book book) {
        if (book == null) {
            return null;
        }
        return new BookResponse(book.getId().toString(), book.getIsbn(), book.getTitle());
    }
}
