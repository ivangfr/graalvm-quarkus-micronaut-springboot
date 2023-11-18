package com.ivanfranchin.kafkaproducer.rest.dto;

import io.micronaut.core.annotation.Introspected;

import jakarta.validation.constraints.NotBlank;

@Introspected
public record CreateNewsRequest(@NotBlank String source, @NotBlank String title) {
}
