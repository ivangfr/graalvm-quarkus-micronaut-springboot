package com.mycompany.kafkaproducer.domain;

import io.micronaut.core.annotation.Introspected;
import lombok.Value;

@Introspected
@Value
public class News {

    String id;
    String source;
    String title;
}
