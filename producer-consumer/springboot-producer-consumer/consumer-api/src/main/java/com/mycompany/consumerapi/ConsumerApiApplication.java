package com.mycompany.consumerapi;

import com.mycompany.consumerapi.domain.News;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.nativex.hint.TypeHint;

// Add the @TypeHint below due to this [issue #659](https://github.com/spring-projects-experimental/spring-native/issues/659)
@TypeHint(types = News.class)
@SpringBootApplication
public class ConsumerApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(ConsumerApiApplication.class, args);
    }

}
