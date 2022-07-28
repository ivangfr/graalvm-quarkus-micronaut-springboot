package com.ivanfranchin.kafkaproducer.rest.dto;

import io.micronaut.core.annotation.Introspected;

import javax.validation.constraints.NotBlank;

@Introspected
public record CreateNewsRequest(@NotBlank String source, @NotBlank String title) {
}
