package com.mycompany.producerapi.kafka;

import io.micronaut.configuration.kafka.annotation.KafkaClient;
import io.micronaut.configuration.kafka.annotation.KafkaKey;
import io.micronaut.configuration.kafka.annotation.Topic;

@KafkaClient
public interface NewsClient {

    @Topic("${app.kafka.output.topic}")
    void send(@KafkaKey String id, NewsMessage newsMessage);

}
