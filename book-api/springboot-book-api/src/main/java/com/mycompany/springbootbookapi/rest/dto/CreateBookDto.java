package com.mycompany.springbootbookapi.rest.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class CreateBookDto {

    @NotBlank
    private String isbn;

    @NotBlank
    private String title;

}
