package com.mycompany.springbootjpamysql;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.nativex.hint.TypeAccess;
import org.springframework.nativex.hint.TypeHint;

@TypeHint(
        typeNames = "org.springframework.validation.beanvalidation.SpringValidatorAdapter$ViolationFieldError",
        access = { TypeAccess.PUBLIC_CONSTRUCTORS, TypeAccess.PUBLIC_METHODS }
)
@SpringBootApplication
public class SpringbootJpaMysqlApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootJpaMysqlApplication.class, args);
    }
}
