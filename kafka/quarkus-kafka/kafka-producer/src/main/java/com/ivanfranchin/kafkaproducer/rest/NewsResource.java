package com.ivanfranchin.kafkaproducer.rest;

import com.ivanfranchin.kafkaproducer.domain.News;
import com.ivanfranchin.kafkaproducer.rest.dto.CreateNewsRequest;
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
    public String createNews(@Valid CreateNewsRequest createNewsRequest) {
        String id = UUID.randomUUID().toString();
        News news = new News(id, createNewsRequest.getSource(), createNewsRequest.getTitle());
        log.info("Sending News message: key={}, {}", id, news);
        emitter.send(KafkaRecord.of(id, news));
        return id;
    }
}
