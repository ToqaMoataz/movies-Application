import 'package:injectable/injectable.dart';
import 'package:movie_app/Features/HomeScreen/data/Data%20Source/movies_data_sources.dart';
import '../../../../Core/APIs/api_manager.dart';
import '../../../../Core/APIs/endpoints.dart';
import '../../../../Core/Models/Movie/YTS  Response Models/yts_movie_response.dart';
import '../../../../Core/Models/Movie/YTS  Response Models/yts_movies_response.dart';


@Named("HomeYTS")
@LazySingleton()
class MoviesYTSDataSourcesImpl
    implements MoviesDataSources<MoviesResponse, MovieResponse> {
  ApiManager api;

  MoviesYTSDataSourcesImpl(this.api);

  @override
  Future<MoviesResponse?> searchMovies(String movieName) async {
    try {
      var response = await api.getApi(
        YTSEndpoints.listMoviesEndpoint,
        params: {"query_term": movieName},
      );
      MoviesResponse result = MoviesResponse.fromJson(response.data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  //browse_movies
  @override
  Future<MoviesResponse?> listMoviesByGenre(dynamic genre) async {
    try {
      var response = await api.getApi(
        YTSEndpoints.listMoviesEndpoint,
        params: {"genre": genre},
      );
      MoviesResponse result = MoviesResponse.fromJson(response.data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MoviesResponse?> listLimitMoviesByGenre(
    dynamic genre,
    int limit,
  ) async {
    if (genre is int) {
      throw Exception("YTS does not support Genre ID (Int). Use TMDB instead.");
    }
    try {
      var response = await api.getApi(
        YTSEndpoints.listMoviesEndpoint,
        params: {"genre": genre, "limit": limit},
      );
      MoviesResponse? result = MoviesResponse.fromJson(response.data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  //recent_movies
  @override
  Future<MoviesResponse?> getRecentMovies() async {
    try {
      var response = await api.getApi(
        YTSEndpoints.listMoviesEndpoint,
        params: {"sort_by": "year", "order_by": "desc", "limit": 10},
      );
      MoviesResponse? result = MoviesResponse.fromJson(response.data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MovieResponse>?> getMoviesByIDs(List<int> ids) async {
    try {
      final responses = await Future.wait(
        ids.map((id) async {
          var response = await api.getApi(
            YTSEndpoints.movieDetailsEndpoint,
            params: {"movie_id": id, "with_images": true, "with_cast": true},
          );
          return MovieResponse.fromJson(response.data);
        }),
      );

      return responses;
    } catch (e) {
      rethrow;
    }
  }
}
