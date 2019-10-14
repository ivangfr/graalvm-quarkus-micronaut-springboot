package com.mycompany.producerapi.rest;

import com.mycompany.producerapi.kafka.NewsClient;
import com.mycompany.producerapi.kafka.NewsMessage;
import com.mycompany.producerapi.rest.dto.CreateNewsDto;
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
    public String createNews(@Valid @Body CreateNewsDto createNewsDto) {
        String id = UUID.randomUUID().toString();
        NewsMessage newsMessage = new NewsMessage(createNewsDto.getSource(), createNewsDto.getTitle());
        log.info("Sending News message: id={}, {}", id, newsMessage);
        newsClient.send(id, newsMessage);
        return id;
    }

}
