package com.mycompany.consumerapi.kafka;

import com.mycompany.consumerapi.domain.News;
import io.smallrye.reactive.messaging.kafka.KafkaMessage;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.microprofile.reactive.messaging.Incoming;

import java.util.concurrent.CompletionStage;

@Slf4j
public class NewsListener {

    @Incoming("news")
    public CompletionStage<Void> receive(KafkaMessage<String, News> kafkaMessage) {
        log.info("Received message\n---\nTOPIC: {}; PARTITION: {}; OFFSET: {}; TIMESTAMP: {};\nKEY: {}\nPAYLOAD: {}\n---",
                kafkaMessage.getTopic(),
                kafkaMessage.getPartition(),
                "", //kafkaMessage.getOffset(),
                kafkaMessage.getTimestamp(),
                kafkaMessage.getKey(),
                kafkaMessage.getPayload());
        return kafkaMessage.ack();
    }

}
