package com.mycompany.springbootelasticsearch;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.HttpStatus;
import org.springframework.nativex.hint.TypeHint;

// --
// Added because of this issue https://github.com/spring-projects-experimental/spring-native/issues/612
@TypeHint(types = HttpStatus.class)
// --
@SpringBootApplication
public class SpringbootElasticsearchApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringbootElasticsearchApplication.class, args);
	}

}
