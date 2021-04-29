package com.mycompany.producerapi.rest;

import com.mycompany.producerapi.domain.News;
import com.mycompany.producerapi.kafka.NewsProducer;
import com.mycompany.producerapi.rest.dto.CreateNewsDto;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

// -- Commented out as 'spring-boot-starter-validation' dependency is not working in native image
// import javax.validation.Valid;
import java.util.UUID;

@RestController
@RequestMapping("/api/news")
public class NewsController {

    private final NewsProducer newsProducer;

    public NewsController(NewsProducer newsProducer) {
        this.newsProducer = newsProducer;
    }

    @PostMapping
    // public String publishNews(@Valid @RequestBody CreateNewsDto createNewsDto) {
    public String publishNews(@RequestBody CreateNewsDto createNewsDto) {
        String id = UUID.randomUUID().toString();
        newsProducer.send(new News(id, createNewsDto.getSource(), createNewsDto.getTitle()));
        return id;
    }

}
