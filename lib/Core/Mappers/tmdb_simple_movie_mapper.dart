import 'package:movie_app/Core/Models/Movie/TMBD%20Response%20Models/tmdb_movies_response_model.dart';

import '../Entities/movie_entity.dart';

extension TmdbSimpleMovieMapper on TMDBMovie {
  MovieSimpleEntity toSimpleMovieEntity() {
    return MovieSimpleEntity(
     id: id,
      movieTitle: title,
      moviePoster: "https://image.tmdb.org/t/p/w500$posterPath",
      rating: voteAverage
    );
  }
}