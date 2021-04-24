package com.mycompany.micronautjpamysql.rest.dto;

import io.micronaut.core.annotation.Introspected;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Introspected
@Data
public class CreateBookDto {

    @NotBlank
    private String isbn;

    @NotBlank
    private String title;

}
