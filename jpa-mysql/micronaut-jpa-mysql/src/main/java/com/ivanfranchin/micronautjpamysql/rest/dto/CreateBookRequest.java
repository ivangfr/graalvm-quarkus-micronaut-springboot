package com.ivanfranchin.micronautjpamysql.rest.dto;

import com.ivanfranchin.micronautjpamysql.model.Book;
import io.micronaut.core.annotation.Introspected;
import jakarta.validation.constraints.NotBlank;

@Introspected
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
