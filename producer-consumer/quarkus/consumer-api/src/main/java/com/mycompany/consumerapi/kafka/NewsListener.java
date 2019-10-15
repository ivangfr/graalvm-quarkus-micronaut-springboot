package com.mycompany.consumerapi.kafka;

import com.mycompany.consumerapi.domain.News;
import io.smallrye.reactive.messaging.kafka.KafkaMessage;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.microprofile.reactive.messaging.Incoming;

@Slf4j
public class NewsListener {

    @Incoming("news")
    public void receive(News news) {
        log.info("Received message\n---\nTOPIC: {}; PARTITION: {}; OFFSET: {}; TIMESTAMP: {};\nKEY: {}\nPAYLOAD: {}\n---",
                "", "", "", "", "", news);
    }

//    @Incoming("news")
//    public void receive(KafkaMessage<String, News> kafkaMessage) {
//        log.info("Received message\n---\nTOPIC: {}; PARTITION: {}; OFFSET: {}; TIMESTAMP: {};\nKEY: {}\nPAYLOAD: {}\n---",
//                kafkaMessage.getTopic(),
//                kafkaMessage.getPartition(),
//                "",
//                kafkaMessage.getTimestamp(),
//                kafkaMessage.getKey(),
//                kafkaMessage.getPayload());
//    }
}
