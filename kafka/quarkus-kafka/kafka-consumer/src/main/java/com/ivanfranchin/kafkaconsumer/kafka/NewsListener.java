package com.ivanfranchin.kafkaconsumer.kafka;

import com.ivanfranchin.kafkaconsumer.domain.News;
import io.smallrye.reactive.messaging.kafka.api.IncomingKafkaRecordMetadata;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import org.eclipse.microprofile.reactive.messaging.Message;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.CompletionStage;

public class NewsListener {

    private static final Logger log = LoggerFactory.getLogger(NewsListener.class);

    @Incoming("news")
    public CompletionStage<Void> receive(Message<News> message) {
        var metadata = message.getMetadata(IncomingKafkaRecordMetadata.class).orElseThrow();
        log.info("Received message\n---\nTOPIC: {}; PARTITION: {}; OFFSET: {}; TIMESTAMP: {};\nKEY: {}\nPAYLOAD: {}\n---",
                metadata.getTopic(),
                metadata.getPartition(),
                metadata.getOffset(),
                metadata.getTimestamp(),
                metadata.getKey(),
                message.getPayload());
        return message.ack();
    }
}
