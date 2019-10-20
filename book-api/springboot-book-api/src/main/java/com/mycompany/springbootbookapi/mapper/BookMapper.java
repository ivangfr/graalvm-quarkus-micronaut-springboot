package com.mycompany.springbootbookapi.mapper;

import com.mycompany.springbootbookapi.model.Book;
import com.mycompany.springbootbookapi.rest.dto.CreateBookDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface BookMapper {

    @Mapping(target = "id", ignore = true)
    Book toBook(CreateBookDto createBookDto);

}
