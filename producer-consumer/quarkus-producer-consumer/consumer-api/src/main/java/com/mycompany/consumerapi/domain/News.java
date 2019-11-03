package com.mycompany.consumerapi.domain;

import io.quarkus.runtime.annotations.RegisterForReflection;
import lombok.Data;

@RegisterForReflection
@Data
public class News {

    private String id;
    private String source;
    private String title;

}
