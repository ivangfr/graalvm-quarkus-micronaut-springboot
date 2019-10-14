package com.mycompany.producerapi.kafka;

import io.micronaut.core.annotation.Introspected;
import lombok.Value;

@Introspected
@Value
public class NewsMessage {

    private String source;
    private String title;

}
