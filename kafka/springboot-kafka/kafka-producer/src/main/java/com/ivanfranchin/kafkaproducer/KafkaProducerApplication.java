package com.ivanfranchin.kafkaproducer;

import com.ivanfranchin.kafkaproducer.domain.News;
import org.springframework.aot.hint.annotation.RegisterReflectionForBinding;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@RegisterReflectionForBinding(News.class)
@SpringBootApplication
public class KafkaProducerApplication {

    public static void main(String[] args) {
        SpringApplication.run(KafkaProducerApplication.class, args);
    }
}
