package com.mycompany.consumerapi.kafka;

import com.mycompany.consumerapi.domain.News;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.listener.adapter.ConsumerRecordMetadata;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class NewsConsumer {

    @KafkaListener(topics = "${kafka.consumer.topic}", groupId = "${kafka.consumer.group-id}")
    public void listen(@Payload News news, ConsumerRecordMetadata metadata) {
        log.info("Received message\n---\nTOPIC: {}; PARTITION: {}; OFFSET: {};\nPAYLOAD: {}\n---", metadata.topic(), metadata.partition(), metadata.offset(), news);
    }

}
