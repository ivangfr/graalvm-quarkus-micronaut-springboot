package com.mycompany.kafkaproducer.rest;

import com.mycompany.kafkaproducer.domain.News;
import com.mycompany.kafkaproducer.kafka.NewsProducer;
import com.mycompany.kafkaproducer.rest.dto.CreateNewsRequest;
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
        newsProducer.send(new News(id, createNewsRequest.getSource(), createNewsRequest.getTitle()));
        return id;
    }
}
