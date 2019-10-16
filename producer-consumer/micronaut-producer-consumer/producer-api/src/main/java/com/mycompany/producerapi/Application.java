package com.mycompany.producerapi;

import io.micronaut.configuration.kafka.metrics.ProducerKafkaMetricsReporter;
import io.micronaut.core.annotation.TypeHint;
import io.micronaut.runtime.Micronaut;

@TypeHint(ProducerKafkaMetricsReporter.class)
public class Application {

    public static void main(String[] args) {
        Micronaut.run(Application.class);
    }
}