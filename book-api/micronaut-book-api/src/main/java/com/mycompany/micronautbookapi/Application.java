package com.mycompany.micronautbookapi;

import com.mycompany.micronautbookapi.exception.BookNotFoundException;

import io.micronaut.core.annotation.TypeHint;
import io.micronaut.runtime.Micronaut;

import static io.micronaut.core.annotation.TypeHint.AccessType;

// added @TypeHint annotation for BookNotFoundException as suggested in this issue: https://github.com/micronaut-projects/micronaut-core/issues/3240
@TypeHint(
    value=BookNotFoundException.class,
    accessType={AccessType.ALL_PUBLIC, AccessType.ALL_DECLARED_CONSTRUCTORS}
)
public class Application {

    public static void main(String[] args) {
        Micronaut.run(Application.class);
    }
}