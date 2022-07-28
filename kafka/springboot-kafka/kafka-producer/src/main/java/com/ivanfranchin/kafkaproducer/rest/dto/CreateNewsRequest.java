package com.ivanfranchin.kafkaproducer.rest.dto;

import javax.validation.constraints.NotBlank;

public record CreateNewsRequest(@NotBlank String source, @NotBlank String title) {
}
