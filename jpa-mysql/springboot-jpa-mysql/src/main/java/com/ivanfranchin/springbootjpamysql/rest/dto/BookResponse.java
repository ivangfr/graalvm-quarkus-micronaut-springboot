package com.ivanfranchin.springbootjpamysql.rest.dto;

import com.ivanfranchin.springbootjpamysql.model.Book;

public record BookResponse(String id, String isbn, String title) {

    public static BookResponse fromBook(Book book) {
        if (book == null) {
            return null;
        }
        return new BookResponse(book.getId().toString(), book.getIsbn(), book.getTitle());
    }
}
