import 'package:movie_app/Core/Models/Movie/TMBD%20Response%20Models/tmdb_movies_response_model.dart';


class SimilarMoviesResponse {
  final int? page;
  final List<TMDBMovie>? results;

  SimilarMoviesResponse({this.page, this.results});

  factory SimilarMoviesResponse.fromJson(Map<String, dynamic> json) {
    return SimilarMoviesResponse(
      page: json['page'],
      results: json['results'] != null
          ? (json['results'] as List)
          .map((e) => TMDBMovie.fromJson(e))
          .toList()
          : [],
    );
  }
}
