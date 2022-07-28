package com.ivanfranchin.springbootjpamysql.rest.dto;

import javax.validation.constraints.NotBlank;

public record CreateBookRequest(@NotBlank String isbn, @NotBlank String title) {
}
