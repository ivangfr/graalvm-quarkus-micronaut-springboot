package com.ivanfranchin.kafkaconsumer.deserializer;

import com.ivanfranchin.kafkaconsumer.domain.News;
import io.quarkus.kafka.client.serialization.ObjectMapperDeserializer;
import io.quarkus.runtime.annotations.RegisterForReflection;

@RegisterForReflection
public class NewsDeserializer extends ObjectMapperDeserializer<News> {

    public NewsDeserializer() {
        super(News.class);
    }
}
