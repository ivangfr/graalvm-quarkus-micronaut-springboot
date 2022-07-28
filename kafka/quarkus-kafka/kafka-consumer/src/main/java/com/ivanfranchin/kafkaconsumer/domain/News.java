package com.ivanfranchin.kafkaconsumer.domain;

import io.quarkus.runtime.annotations.RegisterForReflection;

@RegisterForReflection
public record News(String id, String source, String title) {
}
