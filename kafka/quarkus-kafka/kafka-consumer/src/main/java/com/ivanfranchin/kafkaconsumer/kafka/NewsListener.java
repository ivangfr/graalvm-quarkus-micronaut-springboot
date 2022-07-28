package com.ivanfranchin.kafkaconsumer.kafka;

import com.ivanfranchin.kafkaconsumer.domain.News;
import io.smallrye.reactive.messaging.kafka.IncomingKafkaRecord;
import io.smallrye.reactive.messaging.kafka.KafkaRecord;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.CompletionStage;

public class NewsListener {

    private static final Logger log = LoggerFactory.getLogger(NewsListener.class);

    @Incoming("news")
    public CompletionStage<Void> receive(KafkaRecord<String, News> kafkaRecord) {
        log.info("Received message\n---\nTOPIC: {}; PARTITION: {}; OFFSET: {}; TIMESTAMP: {};\nKEY: {}\nPAYLOAD: {}\n---",
                kafkaRecord.getTopic(),
                kafkaRecord.getPartition(),
                kafkaRecord.unwrap(IncomingKafkaRecord.class).getOffset(),
                kafkaRecord.getTimestamp(),
                kafkaRecord.getKey(),
                kafkaRecord.getPayload());
        return kafkaRecord.ack();
    }
}
