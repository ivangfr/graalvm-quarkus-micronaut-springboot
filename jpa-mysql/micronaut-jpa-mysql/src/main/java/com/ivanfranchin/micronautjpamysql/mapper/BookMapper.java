package com.ivanfranchin.micronautjpamysql.mapper;

import com.ivanfranchin.micronautjpamysql.model.Book;
import com.ivanfranchin.micronautjpamysql.rest.dto.CreateBookRequest;
import jakarta.inject.Singleton;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Singleton
@Mapper(componentModel = "jsr330")
public interface BookMapper {

    @Mapping(target = "id", ignore = true)
    Book toBook(CreateBookRequest createBookRequest);
}
