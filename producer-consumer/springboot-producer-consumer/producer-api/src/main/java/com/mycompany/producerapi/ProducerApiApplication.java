package com.mycompany.producerapi;

import com.mycompany.producerapi.domain.News;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.kafka.support.serializer.JsonSerializer;
import org.springframework.nativex.hint.TypeHint;

// Add the @TypeHint below due to this [issue #659](https://github.com/spring-projects-experimental/spring-native/issues/659)
@TypeHint(types = {JsonSerializer.class, News.class})
@SpringBootApplication
public class ProducerApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(ProducerApiApplication.class, args);
    }

}
