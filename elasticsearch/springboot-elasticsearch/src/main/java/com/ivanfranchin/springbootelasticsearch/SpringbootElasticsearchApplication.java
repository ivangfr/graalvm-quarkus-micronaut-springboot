package com.ivanfranchin.springbootelasticsearch;

import com.ivanfranchin.springbootelasticsearch.config.NativeRuntimeHintsRegistrar;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportRuntimeHints;

@ImportRuntimeHints(NativeRuntimeHintsRegistrar.class)
@SpringBootApplication
public class SpringbootElasticsearchApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootElasticsearchApplication.class, args);
    }
}
