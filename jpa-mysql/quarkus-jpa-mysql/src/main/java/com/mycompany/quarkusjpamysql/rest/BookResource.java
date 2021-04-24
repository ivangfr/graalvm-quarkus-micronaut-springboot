package com.mycompany.quarkusjpamysql.rest;

import com.mycompany.quarkusjpamysql.exception.BookNotFoundException;
import com.mycompany.quarkusjpamysql.mapper.BookMapper;
import com.mycompany.quarkusjpamysql.model.Book;
import com.mycompany.quarkusjpamysql.rest.dto.CreateBookDto;
import com.mycompany.quarkusjpamysql.service.BookService;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;

@Path("/api/books")
public class BookResource {

    @Inject
    BookService bookService;

    @Inject
    BookMapper bookMapper;

    @GET
    public Iterable<Book> getBooks() {
        return bookService.getBooks();
    }

    @GET
    @Path("/{id}")
    public Book getBook(@PathParam("id") Long id) throws BookNotFoundException {
        return bookService.validateAndGetBook(id);
    }

    @POST
    public Response createBook(@Valid CreateBookDto createBookDto) {
        Book book = bookMapper.toBook(createBookDto);
        book = bookService.saveBook(book);
        return Response.status(Response.Status.CREATED).entity(book).build();
    }

}
