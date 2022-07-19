package com.mycompany.kafkaproducer.rest.dto;

import io.micronaut.core.annotation.Introspected;
import lombok.Data;

@Introspected
@Data
public class CreateNewsRequest {

    private String source;
    private String title;
}
