import 'package:movie_app/Core/Models/Movie/YTS%20%20Response%20Models/yts_movie_response.dart';

import '../Entities/movie_entity.dart';

extension YtsSimpleMovieMapper on MovieResponse {
  MovieSimpleEntity toSimpleMovieEntity() {
    return MovieSimpleEntity(
     id: data.movie.id,
      movieTitle: data.movie.title,
      moviePoster: data.movie.mediumCoverImage,
      rating: data.movie.rating
    );
  }
}