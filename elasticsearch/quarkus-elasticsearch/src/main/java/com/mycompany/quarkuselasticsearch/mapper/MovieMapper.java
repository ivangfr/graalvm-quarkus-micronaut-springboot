package com.mycompany.quarkuselasticsearch.mapper;

import com.mycompany.quarkuselasticsearch.model.Movie;
import com.mycompany.quarkuselasticsearch.rest.dto.CreateMovieRequest;
import com.mycompany.quarkuselasticsearch.rest.dto.SearchMovieResponse;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.mapstruct.Mapper;

import java.util.ArrayList;
import java.util.List;

@Mapper(componentModel = "cdi")
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
