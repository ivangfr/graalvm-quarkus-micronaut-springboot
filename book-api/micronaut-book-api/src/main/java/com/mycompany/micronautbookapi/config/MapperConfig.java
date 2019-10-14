package com.mycompany.micronautbookapi.config;

import io.micronaut.context.annotation.Factory;
import ma.glasnost.orika.MapperFacade;
import ma.glasnost.orika.MapperFactory;
import ma.glasnost.orika.impl.DefaultMapperFactory;

import javax.inject.Singleton;

@Factory
public class MapperConfig {

    @Singleton
    MapperFactory mapperFactory() {
        return new DefaultMapperFactory.Builder().useAutoMapping(true).mapNulls(false).build();
    }

    @Singleton
    MapperFacade mapperFacade() {
        return mapperFactory().getMapperFacade();
    }

}
