package com.ivanfranchin.kafkaproducer.rest;

import com.ivanfranchin.kafkaproducer.domain.News;
import com.ivanfranchin.kafkaproducer.kafka.NewsClient;
import com.ivanfranchin.kafkaproducer.rest.dto.CreateNewsRequest;
import io.micronaut.http.annotation.Body;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Post;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jakarta.validation.Valid;
import java.util.UUID;

@Controller("/api/news")
public class NewsController {

    private static final Logger log = LoggerFactory.getLogger(NewsController.class);

    private final NewsClient newsClient;

    public NewsController(NewsClient newsClient) {
        this.newsClient = newsClient;
    }

    @Post
    public String createNews(@Valid @Body CreateNewsRequest createNewsRequest) {
        String id = UUID.randomUUID().toString();
        News newsMessage = new News(id, createNewsRequest.source(), createNewsRequest.title());
        log.info("Sending News message: id={}, {}", id, newsMessage);
        newsClient.send(id, newsMessage);
        return id;
    }
}
