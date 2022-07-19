package com.mycompany.kafkaproducer.domain;

import lombok.Value;

@Value
public class News {

    String id;
    String source;
    String title;
}
