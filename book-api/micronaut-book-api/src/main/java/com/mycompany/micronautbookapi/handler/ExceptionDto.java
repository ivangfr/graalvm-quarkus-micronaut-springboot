package com.mycompany.micronautbookapi.handler;

import io.micronaut.core.annotation.Introspected;
import lombok.Value;

@Introspected
@Value
public class ExceptionDto {

    private String error;
    private String message;
    private String path;
    private int status;
    private String timestamp;

}
