package com.ivanfranchin.springbootjpamysql.rest.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class CreateBookRequest {

    @NotBlank
    private String isbn;

    @NotBlank
    private String title;
}
