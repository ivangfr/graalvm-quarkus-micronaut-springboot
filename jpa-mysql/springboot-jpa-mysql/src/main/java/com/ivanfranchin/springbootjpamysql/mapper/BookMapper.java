package com.ivanfranchin.springbootjpamysql.mapper;

import com.ivanfranchin.springbootjpamysql.model.Book;
import com.ivanfranchin.springbootjpamysql.rest.dto.BookResponse;
import com.ivanfranchin.springbootjpamysql.rest.dto.CreateBookRequest;

public interface BookMapper {

    Book toBook(CreateBookRequest createBookRequest);

    BookResponse toBookResponse(Book book);
}
