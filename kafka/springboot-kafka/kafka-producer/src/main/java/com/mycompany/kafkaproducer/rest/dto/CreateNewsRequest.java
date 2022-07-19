package com.mycompany.kafkaproducer.rest.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class CreateNewsRequest {

    @NotBlank
    private String source;

    @NotBlank
    private String title;
}
