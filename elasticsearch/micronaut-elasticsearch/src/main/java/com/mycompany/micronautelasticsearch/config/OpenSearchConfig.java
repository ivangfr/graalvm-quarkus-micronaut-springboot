package com.mycompany.micronautelasticsearch.config;

import io.micronaut.context.annotation.Factory;
import io.micronaut.context.annotation.Value;
import jakarta.inject.Singleton;
import org.apache.http.HttpHost;
import org.opensearch.client.RestClient;
import org.opensearch.client.RestClientBuilder;
import org.opensearch.client.RestHighLevelClient;

@Factory
public class OpenSearchConfig {

    @Value("${opensearch.host}")
    String openSearchHost;

    @Value("${opensearch.port}")
    int openSearchPort;

    @Value("${opensearch.scheme}")
    String openSearchScheme;

    @Singleton
    public RestHighLevelClient restHighLevelClient() {
        RestClientBuilder builder = RestClient.builder(new HttpHost(openSearchHost, openSearchPort, openSearchScheme));
        return new RestHighLevelClient(builder);
    }
}
