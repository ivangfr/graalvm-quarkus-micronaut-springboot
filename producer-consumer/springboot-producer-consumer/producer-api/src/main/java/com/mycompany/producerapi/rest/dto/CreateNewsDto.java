package com.mycompany.producerapi.rest.dto;

import lombok.Data;

// -- Commented out as 'spring-boot-starter-validation' dependency is not working in native image
//import javax.validation.constraints.NotBlank;

@Data
public class CreateNewsDto {

    // @NotBlank
    private String source;

    // @NotBlank
    private String title;

}
