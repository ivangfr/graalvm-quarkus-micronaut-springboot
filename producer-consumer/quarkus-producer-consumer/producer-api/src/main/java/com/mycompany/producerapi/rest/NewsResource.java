package com.mycompany.producerapi.rest;

import com.mycompany.producerapi.domain.News;
import com.mycompany.producerapi.rest.dto.CreateNewsDto;
import io.smallrye.reactive.messaging.kafka.KafkaRecord;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.microprofile.reactive.messaging.Channel;
import org.eclipse.microprofile.reactive.messaging.Emitter;
import org.eclipse.microprofile.reactive.messaging.OnOverflow;
import org.eclipse.microprofile.reactive.messaging.OnOverflow.Strategy;

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
    @OnOverflow(value = Strategy.BUFFER, bufferSize = 10000)
    Emitter<News> emitter;

    @POST
    public String createNews(@Valid CreateNewsDto createNewsDto) {
        String id = UUID.randomUUID().toString();
        News news = new News(id, createNewsDto.getSource(), createNewsDto.getTitle());
        log.info("Sending News message: key={}, {}", id, news);
        emitter.send(KafkaRecord.of(id, news));
        return id;
    }

}
