package com.mycompany.consumerapi;

import io.micronaut.configuration.kafka.metrics.ConsumerKafkaMetricsReporter;
import io.micronaut.core.annotation.TypeHint;
import io.micronaut.runtime.Micronaut;

@TypeHint(ConsumerKafkaMetricsReporter.class)
public class Application {

    public static void main(String[] args) {
        Micronaut.run(Application.class);
    }
}