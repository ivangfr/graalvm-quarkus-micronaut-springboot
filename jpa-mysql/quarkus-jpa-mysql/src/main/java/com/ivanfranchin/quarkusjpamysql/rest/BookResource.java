package com.ivanfranchin.quarkusjpamysql.rest;

import com.ivanfranchin.quarkusjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.quarkusjpamysql.model.Book;
import com.ivanfranchin.quarkusjpamysql.rest.dto.BookResponse;
import com.ivanfranchin.quarkusjpamysql.rest.dto.CreateBookRequest;
import com.ivanfranchin.quarkusjpamysql.service.BookService;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.core.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

@Path("/api/books")
public class BookResource {

    private static final Logger log = LoggerFactory.getLogger(BookResource.class);

    @Inject
    BookService bookService;

    @GET
    public List<BookResponse> getBooks() {
        log.info("Received request to get all books. Processed by {}", Thread.currentThread());
        return bookService.getBooks().stream().map(BookResponse::fromBook).toList();
    }

    @GET
    @Path("/{id}")
    public BookResponse getBook(@PathParam("id") Long id) throws BookNotFoundException {
        log.info("Received request to get books with id: {}. Processed by {}", id, Thread.currentThread());
        return BookResponse.fromBook(bookService.validateAndGetBook(id));
    }

    @POST
    public Response createBook(@Valid CreateBookRequest createBookRequest) {
        log.info("Received request to create book: {}. Processed by {}", createBookRequest, Thread.currentThread());
        Book book = bookService.saveBook(CreateBookRequest.toBook(createBookRequest));
        return Response.status(Response.Status.CREATED).entity(BookResponse.fromBook(book)).build();
    }
}
