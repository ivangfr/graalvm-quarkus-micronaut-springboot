package com.mycompany.springbootbookapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebAutoConfiguration;

@SpringBootApplication(proxyBeanMethods = false, exclude = SpringDataWebAutoConfiguration.class)
public class SpringbootBookApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootBookApiApplication.class, args);
    }

}
