package com.mycompany.kafkaproducer.domain;

import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.Value;

@RegisterForReflection
@Value
public class News {

    String id;
    String source;
    String title;
}
