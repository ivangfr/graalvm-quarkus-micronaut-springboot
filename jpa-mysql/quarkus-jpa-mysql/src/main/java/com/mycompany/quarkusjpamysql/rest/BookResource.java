package com.mycompany.quarkusjpamysql.rest;

import com.mycompany.quarkusjpamysql.exception.BookNotFoundException;
import com.mycompany.quarkusjpamysql.mapper.BookMapper;
import com.mycompany.quarkusjpamysql.model.Book;
import com.mycompany.quarkusjpamysql.rest.dto.CreateBookRequest;
import com.mycompany.quarkusjpamysql.service.BookService;

import lombok.extern.slf4j.Slf4j;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;

@Slf4j
@Path("/api/books")
public class BookResource {

    @Inject
    BookService bookService;

    @Inject
    BookMapper bookMapper;

    @GET
    public Iterable<Book> getBooks() {
        log.info("Received request to get all books");
        return bookService.getBooks();
    }

    @GET
    @Path("/{id}")
    public Book getBook(@PathParam("id") Long id) throws BookNotFoundException {
        log.info("Received request to get books with id: {}", id);
        return bookService.validateAndGetBook(id);
    }

    @POST
    public Response createBook(@Valid CreateBookRequest createBookRequest) {
        log.info("Received request to create book: {}", createBookRequest);
        Book book = bookMapper.toBook(createBookRequest);
        book = bookService.saveBook(book);
        return Response.status(Response.Status.CREATED).entity(book).build();
    }
}
