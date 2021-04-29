package com.mycompany.springbootjpamysql.rest.dto;

import lombok.Data;

// -- Commented out as 'spring-boot-starter-validation' dependency is not working in native image
// import javax.validation.constraints.NotBlank;

@Data
public class CreateBookDto {

    // @NotBlank
    private String isbn;

    // @NotBlank
    private String title;

}
