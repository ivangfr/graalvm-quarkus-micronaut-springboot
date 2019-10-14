package com.mycompany.producerapi.rest.dto;

import io.micronaut.core.annotation.Introspected;
import lombok.Data;

@Introspected
@Data
public class CreateNewsDto {

    private String source;
    private String title;

}
