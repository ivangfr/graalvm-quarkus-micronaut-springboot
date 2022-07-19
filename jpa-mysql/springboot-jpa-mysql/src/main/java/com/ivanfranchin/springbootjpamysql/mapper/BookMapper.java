package com.ivanfranchin.springbootjpamysql.mapper;

import com.ivanfranchin.springbootjpamysql.model.Book;
import com.ivanfranchin.springbootjpamysql.rest.dto.CreateBookRequest;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface BookMapper {

    @Mapping(target = "id", ignore = true)
    Book toBook(CreateBookRequest createBookRequest);
}
