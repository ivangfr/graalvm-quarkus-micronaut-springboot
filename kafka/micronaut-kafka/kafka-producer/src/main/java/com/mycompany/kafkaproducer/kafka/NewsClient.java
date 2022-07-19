package com.mycompany.kafkaproducer.kafka;

import com.mycompany.kafkaproducer.domain.News;
import io.micronaut.configuration.kafka.annotation.KafkaClient;
import io.micronaut.configuration.kafka.annotation.KafkaKey;
import io.micronaut.configuration.kafka.annotation.Topic;

@KafkaClient
public interface NewsClient {

    @Topic("${app.kafka.output.topics}")
    void send(@KafkaKey String id, News newsMessage);
}
