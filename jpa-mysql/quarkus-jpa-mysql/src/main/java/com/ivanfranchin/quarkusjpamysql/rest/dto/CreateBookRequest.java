package com.ivanfranchin.quarkusjpamysql.rest.dto;

import com.ivanfranchin.quarkusjpamysql.model.Book;
import jakarta.validation.constraints.NotBlank;

public record CreateBookRequest(@NotBlank String isbn, @NotBlank String title) {

    public static Book toBook(CreateBookRequest createBookRequest) {
        if (createBookRequest == null) {
            return null;
        }
        Book book = new Book();
        book.setIsbn(createBookRequest.isbn());
        book.setTitle(createBookRequest.title());
        return book;
    }
}
