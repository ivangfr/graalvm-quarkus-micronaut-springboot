package com.mycompany.consumerapi.deserializer;

import com.mycompany.consumerapi.domain.News;
import io.quarkus.kafka.client.serialization.JsonbDeserializer;

public class NewsDeserializer extends JsonbDeserializer<News> {

    public NewsDeserializer() {
        super(News.class);
    }
}
