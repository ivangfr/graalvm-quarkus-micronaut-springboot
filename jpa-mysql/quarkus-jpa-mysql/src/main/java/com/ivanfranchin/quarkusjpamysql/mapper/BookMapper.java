package com.ivanfranchin.quarkusjpamysql.mapper;

import com.ivanfranchin.quarkusjpamysql.model.Book;
import com.ivanfranchin.quarkusjpamysql.rest.dto.BookResponse;
import com.ivanfranchin.quarkusjpamysql.rest.dto.CreateBookRequest;

public interface BookMapper {

    Book toBook(CreateBookRequest createBookRequest);

    BookResponse toBookResponse(Book book);
}
