package com.ivanfranchin.quarkusjpamysql.rest;

import com.ivanfranchin.quarkusjpamysql.exception.BookNotFoundException;
import com.ivanfranchin.quarkusjpamysql.mapper.BookMapper;
import com.ivanfranchin.quarkusjpamysql.model.Book;
import com.ivanfranchin.quarkusjpamysql.rest.dto.BookResponse;
import com.ivanfranchin.quarkusjpamysql.rest.dto.CreateBookRequest;
import com.ivanfranchin.quarkusjpamysql.service.BookService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.stream.Collectors;

@Path("/api/books")
public class BookResource {

    private static final Logger log = LoggerFactory.getLogger(BookResource.class);

    @Inject
    BookService bookService;

    @Inject
    BookMapper bookMapper;

    @GET
    public List<BookResponse> getBooks() {
        log.info("Received request to get all books");
        return bookService.getBooks().stream().map(bookMapper::toBookResponse).collect(Collectors.toList());
    }

    @GET
    @Path("/{id}")
    public BookResponse getBook(@PathParam("id") Long id) throws BookNotFoundException {
        log.info("Received request to get books with id: {}", id);
        return bookMapper.toBookResponse(bookService.validateAndGetBook(id));
    }

    @POST
    public Response createBook(@Valid CreateBookRequest createBookRequest) {
        log.info("Received request to create book: {}", createBookRequest);
        Book book = bookService.saveBook(bookMapper.toBook(createBookRequest));
        return Response.status(Response.Status.CREATED).entity(bookMapper.toBookResponse(book)).build();
    }
}
