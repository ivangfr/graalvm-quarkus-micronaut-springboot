package com.ivanfranchin.quarkuselasticsearch.model;

import io.quarkus.runtime.annotations.RegisterForReflection;

@RegisterForReflection
public record Movie(String imdb, String title) {
}
