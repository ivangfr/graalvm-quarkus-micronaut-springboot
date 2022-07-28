package com.ivanfranchin.micronautjpamysql.rest.dto;

import io.micronaut.core.annotation.Introspected;

@Introspected
public record BookResponse(String id, String isbn, String title) {
}
