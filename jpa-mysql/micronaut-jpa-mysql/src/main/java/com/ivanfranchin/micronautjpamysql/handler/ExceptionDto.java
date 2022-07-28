package com.ivanfranchin.micronautjpamysql.handler;

import io.micronaut.core.annotation.Introspected;

@Introspected
public record ExceptionDto(String error, String message, String path, int status, String timestamp) {
}
