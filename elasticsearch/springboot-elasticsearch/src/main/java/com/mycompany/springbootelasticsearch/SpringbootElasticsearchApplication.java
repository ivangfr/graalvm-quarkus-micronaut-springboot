package com.mycompany.springbootelasticsearch;

import com.mycompany.springbootelasticsearch.model.Movie;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.nativex.hint.NativeHint;
import org.springframework.nativex.hint.TypeHint;

// Add the @TypeHint below due to this [issue #658](https://github.com/spring-projects-experimental/spring-native/issues/658)
@NativeHint(
        options = {
            "--enable-https",
            "--trace-class-initialization=org.elasticsearch.index.VersionType,org.elasticsearch.index.VersionType$1,org.elasticsearch.index.VersionType$3,org.elasticsearch.index.VersionType$3"
        },
        types = @TypeHint(types = Movie.class)
)
@SpringBootApplication
public class SpringbootElasticsearchApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootElasticsearchApplication.class, args);
    }
}
