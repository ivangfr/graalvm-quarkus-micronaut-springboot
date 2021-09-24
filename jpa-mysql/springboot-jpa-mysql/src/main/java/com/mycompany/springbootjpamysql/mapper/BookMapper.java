package com.mycompany.springbootjpamysql.mapper;

import com.mycompany.springbootjpamysql.model.Book;
import com.mycompany.springbootjpamysql.rest.dto.CreateBookRequest;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface BookMapper {

    @Mapping(target = "id", ignore = true)
    Book toBook(CreateBookRequest createBookRequest);
}
