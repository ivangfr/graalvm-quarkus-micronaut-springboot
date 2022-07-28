package com.ivanfranchin.kafkaproducer.kafka;

import com.ivanfranchin.kafkaproducer.domain.News;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class NewsProducer {

    private static final Logger log = LoggerFactory.getLogger(NewsProducer.class);

    private final KafkaTemplate<String, News> kafkaTemplate;

    public NewsProducer(KafkaTemplate<String, News> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    @Value("${spring.kafka.producer.topic}")
    private String kafkaTopic;

    public void send(News news) {
        log.info("Sending News '{}' to topic '{}'", news, kafkaTopic);
        kafkaTemplate.send(kafkaTopic, news.id(), news);
    }
}
