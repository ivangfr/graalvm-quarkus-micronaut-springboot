package com.mycompany.producerapi.rest;

import com.mycompany.producerapi.domain.News;
import com.mycompany.producerapi.rest.dto.CreateNewsDto;
import io.smallrye.reactive.messaging.annotations.Channel;
import io.smallrye.reactive.messaging.annotations.Emitter;
import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import java.util.UUID;

@Slf4j
@Path("/api/news")
public class NewsResource {

    @Inject
    @Channel("news")
    Emitter<News> emitter;

    @POST
    public String createNews(@Valid CreateNewsDto createNewsDto) {
        String id = UUID.randomUUID().toString();
        News news = new News(id, createNewsDto.getSource(), createNewsDto.getTitle());
        log.info("Sending News message: id=, {}", news);
        emitter.send(news);
        return id;
    }

}
