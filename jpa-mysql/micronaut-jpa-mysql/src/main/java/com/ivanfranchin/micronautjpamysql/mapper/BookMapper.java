package com.ivanfranchin.micronautjpamysql.mapper;

import com.ivanfranchin.micronautjpamysql.model.Book;
import com.ivanfranchin.micronautjpamysql.rest.dto.BookResponse;
import com.ivanfranchin.micronautjpamysql.rest.dto.CreateBookRequest;

public interface BookMapper {

    Book toBook(CreateBookRequest createBookRequest);

    BookResponse toBookResponse(Book book);
}
