

import '../../../../Core/Entities/movie_entity.dart';
import '../Models/Movie/TMBD Response Models/tmdb_movies_response_model.dart';

extension TMDBMapper on TMDBMovieResponse {

  MoviesEntity toMoviesEntity() {
    return MoviesEntity(
      moviesCount: totalResults,
      pageNumber: page,
      totalPages: totalPages,
      movies: results.map((m) => MovieSimpleEntity(
        id: m.id,
        moviePoster: "https://image.tmdb.org/t/p/w500${m.posterPath}",
        movieTitle: m.title,
        rating: m.voteAverage,
      )).toList(),
    );
  }
}