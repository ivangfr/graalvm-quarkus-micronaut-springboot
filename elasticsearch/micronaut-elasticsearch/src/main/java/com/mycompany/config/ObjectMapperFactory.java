package com.mycompany.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.micronaut.context.annotation.Factory;

import javax.inject.Singleton;

@Factory
public class ObjectMapperFactory {

    @Singleton
    ObjectMapper objectMapper() {
        return new ObjectMapper();
    }

}
