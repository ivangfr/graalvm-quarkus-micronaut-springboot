package com.mycompany.kafkaconsumer.deserializer;

import com.mycompany.kafkaconsumer.domain.News;
import io.quarkus.kafka.client.serialization.JsonbDeserializer;
import io.quarkus.runtime.annotations.RegisterForReflection;

@RegisterForReflection
public class NewsDeserializer extends JsonbDeserializer<News> {

    public NewsDeserializer() {
        super(News.class);
    }
}
