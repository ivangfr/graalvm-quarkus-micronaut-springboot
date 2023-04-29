package com.ivanfranchin.quarkusjpamysql.mapper;

import com.ivanfranchin.quarkusjpamysql.model.Book;
import com.ivanfranchin.quarkusjpamysql.rest.dto.BookResponse;
import com.ivanfranchin.quarkusjpamysql.rest.dto.CreateBookRequest;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class BookMapperImpl implements BookMapper {

    @Override
    public Book toBook(CreateBookRequest createBookRequest) {
        if (createBookRequest == null) {
            return null;
        }
        Book book = new Book();
        book.setIsbn(createBookRequest.isbn());
        book.setTitle(createBookRequest.title());
        return book;
    }

    @Override
    public BookResponse toBookResponse(Book book) {
        if (book == null) {
            return null;
        }
        return new BookResponse(book.getId().toString(), book.getIsbn(), book.getTitle());
    }
}
