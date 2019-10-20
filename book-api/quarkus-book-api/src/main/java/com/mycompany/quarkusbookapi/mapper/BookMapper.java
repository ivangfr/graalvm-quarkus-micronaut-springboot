package com.mycompany.quarkusbookapi.mapper;

import com.mycompany.quarkusbookapi.model.Book;
import com.mycompany.quarkusbookapi.rest.dto.CreateBookDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "cdi")
public interface BookMapper {

    @Mapping(target = "id", ignore = true)
    Book toBook(CreateBookDto createBookDto);

}
