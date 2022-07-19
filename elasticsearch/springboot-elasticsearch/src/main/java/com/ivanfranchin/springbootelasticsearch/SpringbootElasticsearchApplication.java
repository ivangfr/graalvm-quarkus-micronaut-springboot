package com.ivanfranchin.springbootelasticsearch;

import com.ivanfranchin.springbootelasticsearch.model.Movie;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.nativex.hint.NativeHint;
import org.springframework.nativex.hint.TypeAccess;
import org.springframework.nativex.hint.TypeHint;

// Add the @TypeHint below due to this [issue #658](https://github.com/spring-projects-experimental/spring-native/issues/658)
@NativeHint(
        options = {"--enable-https"},
        types = @TypeHint(
                types = Movie.class,
                access = {TypeAccess.PUBLIC_CONSTRUCTORS, TypeAccess.PUBLIC_METHODS}
        )
)
@SpringBootApplication
public class SpringbootElasticsearchApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootElasticsearchApplication.class, args);
    }
}
