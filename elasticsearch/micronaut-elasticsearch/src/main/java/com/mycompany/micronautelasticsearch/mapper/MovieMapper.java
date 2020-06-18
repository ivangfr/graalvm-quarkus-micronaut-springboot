package com.mycompany.micronautelasticsearch.mapper;

import com.mycompany.micronautelasticsearch.model.Movie;
import com.mycompany.micronautelasticsearch.rest.dto.CreateMovieRequest;
import com.mycompany.micronautelasticsearch.rest.dto.SearchMovieResponse;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.mapstruct.Mapper;

import javax.inject.Singleton;
import java.util.ArrayList;
import java.util.List;

@Singleton
@Mapper(componentModel = "jsr330")
public interface MovieMapper {

    Movie toMovie(CreateMovieRequest createMovieRequest);

    default SearchMovieResponse toSearchMovieResponse(SearchHits searchHits, TimeValue took) {
        SearchMovieResponse searchMovieResponse = new SearchMovieResponse();
        List<SearchMovieResponse.Hit> hits = new ArrayList<>();
        for (SearchHit searchHit : searchHits.getHits()) {
            SearchMovieResponse.Hit hit = new SearchMovieResponse.Hit();
            hit.setIndex(searchHit.getIndex());
            hit.setId(searchHit.getId());
            hit.setScore(searchHit.getScore());
            hit.setSource(searchHit.getSourceAsString());
            hits.add(hit);
        }
        searchMovieResponse.setHits(hits);
        searchMovieResponse.setTook(took.toString());
        return searchMovieResponse;
    }
}
