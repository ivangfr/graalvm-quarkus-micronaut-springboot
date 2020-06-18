package com.mycompany.quarkuselasticsearch.mapper;

import com.mycompany.quarkuselasticsearch.model.Movie;
import com.mycompany.quarkuselasticsearch.rest.dto.CreateMovieRequest;
import com.mycompany.quarkuselasticsearch.rest.dto.SearchMovieResponse;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.mapstruct.Mapper;

@Mapper(componentModel = "cdi")
public interface MovieMapper {

    Movie toMovie(CreateMovieRequest createMovieRequest);

    default SearchMovieResponse toSearchMovieResponse(SearchHits searchHits, TimeValue took) {
        SearchMovieResponse searchMovieResponse = new SearchMovieResponse();
        for (SearchHit searchHit : searchHits.getHits()) {
            SearchMovieResponse.Hit hit = new SearchMovieResponse.Hit();
            hit.setIndex(searchHit.getIndex());
            hit.setId(searchHit.getId());
            hit.setScore(searchHit.getScore());
            hit.setSource(searchHit.getSourceAsString());
            searchMovieResponse.getHits().add(hit);
        }
        searchMovieResponse.setTook(took.toString());
        return searchMovieResponse;
    }
}
