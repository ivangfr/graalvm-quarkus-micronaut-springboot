package com.ivanfranchin.kafkaproducer.kafka;

import com.ivanfranchin.kafkaproducer.domain.News;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class NewsProducer {

    private final KafkaTemplate<String, News> kafkaTemplate;

    public NewsProducer(KafkaTemplate<String, News> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    @Value("${spring.kafka.producer.topic}")
    private String kafkaTopic;

    public void send(News news) {
        log.info("Sending News '{}' to topic '{}'", news, kafkaTopic);
        kafkaTemplate.send(kafkaTopic, news.getId(), news);
    }
}
