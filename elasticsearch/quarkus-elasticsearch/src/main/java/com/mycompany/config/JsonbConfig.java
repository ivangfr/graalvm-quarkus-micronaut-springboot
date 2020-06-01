package com.mycompany.config;

import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Produces;
import javax.json.bind.Jsonb;
import javax.json.bind.JsonbBuilder;

@Dependent
public class JsonbConfig {

    @Produces
    Jsonb jsonb() {
        return JsonbBuilder.create();
    }

}
