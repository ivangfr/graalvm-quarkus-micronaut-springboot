package com.mycompany.kafkaproducer.rest;

import com.mycompany.kafkaproducer.kafka.NewsClient;
import com.mycompany.kafkaproducer.domain.News;
import com.mycompany.kafkaproducer.rest.dto.CreateNewsRequest;
import io.micronaut.http.annotation.Body;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Post;
import lombok.extern.slf4j.Slf4j;

import javax.validation.Valid;
import java.util.UUID;

@Slf4j
@Controller("/api/news")
public class NewsController {

    private final NewsClient newsClient;

    public NewsController(NewsClient newsClient) {
        this.newsClient = newsClient;
    }

    @Post
    public String createNews(@Valid @Body CreateNewsRequest createNewsRequest) {
        String id = UUID.randomUUID().toString();
        News newsMessage = new News(id, createNewsRequest.getSource(), createNewsRequest.getTitle());
        log.info("Sending News message: id={}, {}", id, newsMessage);
        newsClient.send(id, newsMessage);
        return id;
    }
}
