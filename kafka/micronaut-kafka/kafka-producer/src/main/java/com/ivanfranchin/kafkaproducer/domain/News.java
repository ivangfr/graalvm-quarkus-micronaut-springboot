package com.ivanfranchin.kafkaproducer.domain;

import io.micronaut.core.annotation.Introspected;

@Introspected
public record News(String id, String source, String title) {
}
