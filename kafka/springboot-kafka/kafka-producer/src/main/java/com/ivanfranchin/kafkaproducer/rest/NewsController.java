package com.ivanfranchin.kafkaproducer.rest;

import com.ivanfranchin.kafkaproducer.domain.News;
import com.ivanfranchin.kafkaproducer.kafka.NewsProducer;
import com.ivanfranchin.kafkaproducer.rest.dto.CreateNewsRequest;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import java.util.UUID;

@RestController
@RequestMapping("/api/news")
public class NewsController {

    private final NewsProducer newsProducer;

    public NewsController(NewsProducer newsProducer) {
        this.newsProducer = newsProducer;
    }

    @PostMapping
    public String publishNews(@Valid @RequestBody CreateNewsRequest createNewsRequest) {
        String id = UUID.randomUUID().toString();
        newsProducer.send(new News(id, createNewsRequest.source(), createNewsRequest.title()));
        return id;
    }
}
