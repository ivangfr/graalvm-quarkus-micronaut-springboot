package com.mycompany.consumerapi.kafka;

import io.micronaut.core.annotation.Introspected;
import lombok.Data;

@Introspected
@Data
public class NewsMessage {

    private String source;
    private String title;

}
