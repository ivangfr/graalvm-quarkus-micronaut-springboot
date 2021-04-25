package com.mycompany.quarkusjpamysql.mapper;

import com.mycompany.quarkusjpamysql.exception.BookNotFoundException;

import javax.json.Json;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;
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
