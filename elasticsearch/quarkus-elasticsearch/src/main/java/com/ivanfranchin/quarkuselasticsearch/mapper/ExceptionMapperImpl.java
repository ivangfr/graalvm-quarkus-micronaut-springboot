package com.ivanfranchin.quarkuselasticsearch.mapper;

import jakarta.json.Json;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.ext.ExceptionMapper;
import jakarta.ws.rs.ext.Provider;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Provider
public class ExceptionMapperImpl implements ExceptionMapper<Exception> {

    @Override
    public Response toResponse(Exception exception) {
        int status = 400;
        String error = Response.Status.BAD_REQUEST.getReasonPhrase();
        if (exception instanceof WebApplicationException) {
            status = ((WebApplicationException) exception).getResponse().getStatus();
        }

        return Response.status(status)
                .entity(
                        Json.createObjectBuilder()
                                .add("error", error)
                                .add("message", exception.getMessage())
                                .add("path", "")
                                .add("status", status)
                                .add("timestamp", ZonedDateTime.now().format(DateTimeFormatter.ISO_OFFSET_DATE_TIME))
                                .build()
                )
                .build();
    }
}
