package com.mycompany.micronautbookapi.handler;

import io.micronaut.core.annotation.Introspected;
import lombok.Value;

@Introspected
@Value
public class ExceptionDto {

    String error;
    String message;
    String path;
    int status;
    String timestamp;

}
