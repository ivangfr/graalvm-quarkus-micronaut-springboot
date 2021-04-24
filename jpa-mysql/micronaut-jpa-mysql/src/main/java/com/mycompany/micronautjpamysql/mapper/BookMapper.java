package com.mycompany.micronautjpamysql.mapper;

import com.mycompany.micronautjpamysql.model.Book;
import com.mycompany.micronautjpamysql.rest.dto.CreateBookDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import javax.inject.Singleton;

@Singleton
@Mapper(componentModel = "jsr330")
public interface BookMapper {

    @Mapping(target = "id", ignore = true)
    Book toBook(CreateBookDto createBookDto);

}
