package com.mycompany.springbootelasticsearch.config;

import org.apache.http.HttpHost;
import org.opensearch.client.RestClient;
import org.opensearch.client.RestClientBuilder;
import org.opensearch.client.RestHighLevelClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenSearchConfig {

    @Value("${opensearch.host}")
    String openSearchHost;

    @Value("${opensearch.port}")
    int openSearchPort;

    @Value("${opensearch.scheme}")
    String openSearchScheme;

    @Bean
    RestHighLevelClient restHighLevelClient() {
        RestClientBuilder builder = RestClient.builder(new HttpHost(openSearchHost, openSearchPort, openSearchScheme));
        return new RestHighLevelClient(builder);
    }
}
