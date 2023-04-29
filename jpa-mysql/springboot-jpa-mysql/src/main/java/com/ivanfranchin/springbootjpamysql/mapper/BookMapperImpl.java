package com.ivanfranchin.springbootjpamysql.mapper;

import com.ivanfranchin.springbootjpamysql.model.Book;
import com.ivanfranchin.springbootjpamysql.rest.dto.BookResponse;
import com.ivanfranchin.springbootjpamysql.rest.dto.CreateBookRequest;
import org.springframework.stereotype.Service;

@Service
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
