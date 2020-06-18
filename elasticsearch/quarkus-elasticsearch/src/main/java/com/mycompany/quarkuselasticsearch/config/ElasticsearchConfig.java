package com.mycompany.quarkuselasticsearch.config;

import org.apache.http.HttpHost;
import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;

import javax.enterprise.context.Dependent;
import javax.enterprise.inject.Produces;
import java.util.List;

@Dependent
public class ElasticsearchConfig {

    @ConfigProperty(name = "elasticsearch.hosts")
    List<String> hosts;

    @Produces
    RestHighLevelClient restHighLevelClient() {
        HttpHost[] httpHosts = hosts.stream().map(HttpHost::create).toArray(HttpHost[]::new);
        return new RestHighLevelClient(RestClient.builder(httpHosts));
    }

//    @Produces
//    RestHighLevelClient restHighLevelClient(RestClientBuilder restClientBuilder) {
//        return new RestHighLevelClient(restClientBuilder);
//    }
//
//    @Produces
//    @DefaultBean
//    public RestClient restClient(RestClientBuilder restClientBuilder) {
//        return restClientBuilder.build();
//    }
//
//    @Produces
//    @DefaultBean
//    public RestClientBuilder restClientBuilder() {
//        HttpHost[] httpHosts = hosts.stream().map(HttpHost::create).toArray(HttpHost[]::new);
//        return RestClient.builder(httpHosts);
//    }

}
