package com.ivanfranchin.micronautjpamysql.rest.dto;

import io.micronaut.core.annotation.Introspected;

import javax.validation.constraints.NotBlank;

@Introspected
public record CreateBookRequest(@NotBlank String isbn, @NotBlank String title) {
}
