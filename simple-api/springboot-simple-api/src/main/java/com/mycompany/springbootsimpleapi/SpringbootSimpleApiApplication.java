package com.mycompany.springbootsimpleapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(proxyBeanMethods = false)
public class SpringbootSimpleApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootSimpleApiApplication.class, args);
    }

}
