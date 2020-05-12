package com.mycompany.consumerapi.kafka;

import com.mycompany.consumerapi.domain.News;
import io.smallrye.reactive.messaging.kafka.IncomingKafkaRecord;
import io.smallrye.reactive.messaging.kafka.KafkaRecord;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.microprofile.reactive.messaging.Incoming;

import java.util.concurrent.CompletionStage;

@Slf4j
public class NewsListener {

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
