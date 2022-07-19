package com.ivanfranchin.springbootsimpleapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.nativex.hint.AotProxyHint;
import org.springframework.nativex.hint.ProxyBits;

@AotProxyHint(targetClass = com.ivanfranchin.springbootsimpleapi.rest.SimpleApiController.class, proxyFeatures = ProxyBits.IS_STATIC)
@SpringBootApplication
public class SpringbootSimpleApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpringbootSimpleApiApplication.class, args);
    }
}
