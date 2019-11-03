package com.mycompany.producerapi.domain;

import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.Value;

@RegisterForReflection
@Value
public class News {

    private String id;
    private String source;
    private String title;

}
