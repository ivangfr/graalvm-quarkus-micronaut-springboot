package com.ivanfranchin.kafkaconsumer.kafka;

import com.ivanfranchin.kafkaconsumer.domain.News;
import io.micronaut.configuration.kafka.annotation.KafkaKey;
import io.micronaut.configuration.kafka.annotation.KafkaListener;
import io.micronaut.configuration.kafka.annotation.OffsetReset;
import io.micronaut.configuration.kafka.annotation.Topic;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@KafkaListener(groupId = "${app.kafka.group-id}", offsetReset = OffsetReset.EARLIEST)
public class NewsListener {

    private static final Logger log = LoggerFactory.getLogger(NewsListener.class);

    @Topic("${app.kafka.input.topics}")
    public void receive(@KafkaKey String key, News newsMessage, long offset, int partition, String topic, long timestamp) {
        log.info("Received message\n---\nTOPIC: {}; PARTITION: {}; OFFSET: {}; TIMESTAMP: {};\nKEY: {}\nPAYLOAD: {}\n---",
                topic, partition, offset, timestamp, key, newsMessage);
    }
}
