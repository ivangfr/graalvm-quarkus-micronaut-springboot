package com.ivanfranchin.micronautsimpleapi.domain;

import io.micronaut.core.annotation.Introspected;

@Introspected
public record Greeting(String message) {
}
