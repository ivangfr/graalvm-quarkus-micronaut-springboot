package com.ivanfranchin.quarkusjpamysql.mapper;

import com.ivanfranchin.quarkusjpamysql.exception.BookNotFoundException;

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
        int status = 500;
        String error = Response.Status.INTERNAL_SERVER_ERROR.getReasonPhrase();
        if (exception instanceof WebApplicationException) {
            status = ((WebApplicationException) exception).getResponse().getStatus();
        } else if (exception instanceof BookNotFoundException) {
            status = 404;
            error = Response.Status.NOT_FOUND.getReasonPhrase();
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
