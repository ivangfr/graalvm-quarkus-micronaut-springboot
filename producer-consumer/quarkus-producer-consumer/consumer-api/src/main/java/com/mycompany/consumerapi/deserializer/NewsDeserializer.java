package com.mycompany.consumerapi.deserializer;

import com.mycompany.consumerapi.domain.News;
import io.quarkus.kafka.client.serialization.JsonbDeserializer;
import io.quarkus.runtime.annotations.RegisterForReflection;

@RegisterForReflection
public class NewsDeserializer extends JsonbDeserializer<News> {

    public NewsDeserializer() {
        super(News.class);
    }
}
