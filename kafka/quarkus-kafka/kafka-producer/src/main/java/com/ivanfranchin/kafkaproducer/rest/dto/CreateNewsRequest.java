package com.ivanfranchin.kafkaproducer.rest.dto;

import jakarta.validation.constraints.NotBlank;

public record CreateNewsRequest(@NotBlank String source, @NotBlank String title) {
}
