package com.mycompany.quarkuselasticsearch.config;

import org.apache.http.HttpHost;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.opensearch.client.RestClient;
import org.opensearch.client.RestClientBuilder;
import org.opensearch.client.RestHighLevelClient;

import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Produces;

@Dependent
public class OpenSearchConfig {

    @ConfigProperty(name = "opensearch.host")
    String openSearchHost;

    @ConfigProperty(name = "opensearch.port")
    int openSearchPort;

    @ConfigProperty(name = "opensearch.scheme")
    String openSearchScheme;

    @Produces
    public RestHighLevelClient restHighLevelClient() {
        RestClientBuilder builder = RestClient.builder(new HttpHost(openSearchHost, openSearchPort, openSearchScheme));
        return new RestHighLevelClient(builder);
    }
}
