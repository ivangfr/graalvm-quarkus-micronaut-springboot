package com.mycompany.micronautbookapi.mapper;

import com.mycompany.micronautbookapi.model.Book;
import com.mycompany.micronautbookapi.rest.dto.CreateBookDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import javax.inject.Singleton;

@Singleton
@Mapper(componentModel = "jsr330")
public interface BookMapper {

    @Mapping(target = "id", ignore = true)
    Book toBook(CreateBookDto createBookDto);

}
