package com.ivanfranchin.kafkaconsumer.deserializer;

import com.ivanfranchin.kafkaconsumer.domain.News;
import io.quarkus.kafka.client.serialization.JsonbDeserializer;
import io.quarkus.runtime.annotations.RegisterForReflection;

@RegisterForReflection
public class NewsDeserializer extends JsonbDeserializer<News> {

    public NewsDeserializer() {
        super(News.class);
    }
}
