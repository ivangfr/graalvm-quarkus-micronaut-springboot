package com.mycompany.producerapi.domain;

import io.micronaut.core.annotation.Introspected;
import lombok.Value;

@Introspected
@Value
public class News {

    private String id;
    private String source;
    private String title;

}
