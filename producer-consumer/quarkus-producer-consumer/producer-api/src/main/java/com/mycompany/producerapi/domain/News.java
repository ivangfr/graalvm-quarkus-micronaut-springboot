package com.mycompany.producerapi.domain;

import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.Value;

@RegisterForReflection
@Value
public class News {

    String id;
    String source;
    String title;

}
