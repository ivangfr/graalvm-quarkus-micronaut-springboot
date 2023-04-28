package com.ivanfranchin.kafkaproducer.rest;

import com.ivanfranchin.kafkaproducer.domain.News;
import com.ivanfranchin.kafkaproducer.rest.dto.CreateNewsRequest;
import io.smallrye.reactive.messaging.kafka.KafkaRecord;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import org.eclipse.microprofile.reactive.messaging.Channel;
import org.eclipse.microprofile.reactive.messaging.Emitter;
import org.eclipse.microprofile.reactive.messaging.OnOverflow;
import org.eclipse.microprofile.reactive.messaging.OnOverflow.Strategy;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.UUID;

@Path("/api/news")
public class NewsResource {

    private static final Logger log = LoggerFactory.getLogger(NewsResource.class);

    @Inject
    @Channel("news")
    @OnOverflow(value = Strategy.BUFFER, bufferSize = 10000)
    Emitter<News> emitter;

    @POST
    public String createNews(@Valid CreateNewsRequest createNewsRequest) {
        String id = UUID.randomUUID().toString();
        News news = new News(id, createNewsRequest.source(), createNewsRequest.title());
        log.info("Sending News message: key={}, {}", id, news);
        emitter.send(KafkaRecord.of(id, news));
        return id;
    }
}
