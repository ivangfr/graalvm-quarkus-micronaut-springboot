package com.ivanfranchin.quarkusjpamysql.rest.dto;

import jakarta.validation.constraints.NotBlank;

public record CreateBookRequest(@NotBlank String isbn, @NotBlank String title) {
}
