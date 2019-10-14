package com.mycompany.consumerapi.kafka;

import io.micronaut.configuration.kafka.annotation.KafkaKey;
import io.micronaut.configuration.kafka.annotation.KafkaListener;
import io.micronaut.configuration.kafka.annotation.OffsetReset;
import io.micronaut.configuration.kafka.annotation.Topic;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@KafkaListener(groupId = "${app.kafka.group-id}", offsetReset = OffsetReset.EARLIEST)
public class NewsListener {

    @Topic("${app.kafka.input.topics}")
    public void receive(@KafkaKey String id, NewsMessage newsMessage, long offset, int partition, String topic, long timestamp) {
        log.info("Received message\n---\nTOPIC: {}; PARTITION: {}; OFFSET: {}; TIMESTAMP: {};\nID: {}\nPAYLOAD: {}\n---",
                topic, partition, offset, timestamp, id, newsMessage);
    }

}
