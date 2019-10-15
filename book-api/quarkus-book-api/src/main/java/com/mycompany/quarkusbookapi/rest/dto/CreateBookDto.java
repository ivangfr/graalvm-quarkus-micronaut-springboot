package com.mycompany.quarkusbookapi.rest.dto;

import javax.validation.constraints.NotBlank;

public class CreateBookDto {

    @NotBlank
    private String isbn;

    @NotBlank
    private String title;

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
