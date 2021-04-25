package com.mycompany.quarkusjpamysql.mapper;

import com.mycompany.quarkusjpamysql.model.Book;
import com.mycompany.quarkusjpamysql.rest.dto.CreateBookDto;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "cdi")
public interface BookMapper {

    @Mapping(target = "id", ignore = true)
    Book toBook(CreateBookDto createBookDto);

}
