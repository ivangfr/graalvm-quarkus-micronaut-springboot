package com.ivanfranchin.kafkaconsumer.domain;

import io.micronaut.core.annotation.Introspected;
import lombok.Data;

@Introspected
@Data
public class News {

    private String id;
    private String source;
    private String title;
}
