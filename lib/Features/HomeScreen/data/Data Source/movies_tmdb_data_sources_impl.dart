import 'package:injectable/injectable.dart';
import 'package:movie_app/Features/HomeScreen/data/Data%20Source/movies_data_sources.dart';
import '../../../../Core/APIs/api_manager.dart';
import '../../../../Core/APIs/endpoints.dart';
import '../../../../Core/Models/Movie/TMBD Response Models/tmdb_movies_response_model.dart';

@Named("HomeTMDB")
@LazySingleton()
class MoviesTmdbDataSourcesImpl implements MoviesDataSources<TMDBMovieResponse,TMDBMovie>{
  ApiManager api;

  MoviesTmdbDataSourcesImpl(this.api);


  @override
  Future<TMDBMovieResponse> searchMovies(String movieName) async {
    try {
      var response = await api.getApi(TMDBEndpoints.searchMoviesEndpoint, params: {
        "query": movieName
      });
      TMDBMovieResponse result = TMDBMovieResponse.fromJson(response.data);
      return result;
    }catch(e){
      rethrow;
    }
  }

  //browse_movies
  @override
  Future<TMDBMovieResponse> listMoviesByGenre(dynamic genre) async {
    try {
      var response = await api.getApi(
        TMDBEndpoints.listMoviesEndpoint,
        params: {
          "with_genres": genre,
        },
      );
      TMDBMovieResponse result = TMDBMovieResponse.fromJson(response.data);
      return result;
    } catch (e) {
      print("Data Source: ${e.toString()}");
      rethrow;
    }
  }


  @override
  Future<TMDBMovieResponse> listLimitMoviesByGenre(dynamic genre,int limit) async {
    try {
      var response = await api.getApi(
        TMDBEndpoints.listMoviesEndpoint,
        params: {
          "with_genres": genre,
          "page":1
        },
      );
      TMDBMovieResponse result = TMDBMovieResponse.fromJson(response.data);
      return result;
    } catch (e) {
      rethrow;
    }
  }


  //recent_movies
  @override
  Future<TMDBMovieResponse> getRecentMovies() async {
    try {
      var response = await api.getApi(TMDBEndpoints.listTopRatedMovies, params: {
        "page": 1,
      });
      TMDBMovieResponse result = TMDBMovieResponse.fromJson(response.data);
      return result;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<TMDBMovie>> getMoviesByIDs(List<int> ids) async {
    try {
      final responses = await Future.wait(ids.map((id) async {
        var response = await api.getApi(
          TMDBEndpoints.movieDetailsEndpoint(id),
        );
        return TMDBMovie.fromJson(response.data);
      }));

      return responses;
    } catch (e) {
      rethrow;
    }
  }





}