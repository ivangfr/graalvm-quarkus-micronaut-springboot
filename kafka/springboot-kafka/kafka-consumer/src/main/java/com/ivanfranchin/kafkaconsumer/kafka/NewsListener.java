package com.ivanfranchin.kafkaconsumer.kafka;

import com.ivanfranchin.kafkaconsumer.domain.News;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.listener.adapter.ConsumerRecordMetadata;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;

@Service
public class NewsListener {

    private static final Logger log = LoggerFactory.getLogger(NewsListener.class);

    @KafkaListener(topics = "${spring.kafka.consumer.topic}", groupId = "${spring.kafka.consumer.group-id}")
    public void listen(@Payload News news,
                       @Header(KafkaHeaders.RECEIVED_KEY) String key,
                       @Header(KafkaHeaders.RECEIVED_TIMESTAMP) long timestamp,
                       ConsumerRecordMetadata metadata) {
        log.info("Received message\n---\nTOPIC: {}; PARTITION: {}; OFFSET: {}; TIMESTAMP: {};\nKEY: {}\nPAYLOAD: {}\n---. Processed by {}", metadata.topic(), metadata.partition(), metadata.offset(), timestamp, key, news, Thread.currentThread());
    }
}
