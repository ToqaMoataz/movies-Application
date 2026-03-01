import 'package:movie_app/Features/HomeScreen/data/Data%20Source/movies_data_sources.dart';
import 'package:movie_app/Features/moviesDetails/data/Data%20Sources/dataSource.dart';

import '../../../../Core/APIs/api_manager.dart';
import '../../../../Core/APIs/endpoints.dart';
import '../../../../Core/Models/MoviesResponse.dart';
import '../../../../Core/Models/movie_model.dart';
import '../../../moviesDetails/data/Repo Imlementation/movie_details_repo_Imp.dart';
import '../../../moviesDetails/domain/Movies Details Repo/movie_details_repo.dart';

class MoviesTmdbDataSourcesImpl extends MoviesDataSources{
  ApiManager api=ApiManager();
  MovieDetailsRepo repo=MovieDetailsRepoImp(MoviesDetailsImpDs());

  MoviesTmdbDataSourcesImpl(this.repo);
  /////////// List_Movies

  @override
  Future<MoviesResponse> searchMovies(String movieName) async {
    try {
      var response = await api.getApi(YTSEndpoints.listMoviesEndpoint, params: {
        "query_term": movieName
      });
      MoviesResponse result = MoviesResponse.fromJson(response.data);
      return result;
    }catch(e){
      rethrow;
    }
  }

  //browse_movies
  @override
  Future<MoviesResponse> listMoviesByGenre(String genre) async {
    try {
      var response = await api.getApi(
        YTSEndpoints.listMoviesEndpoint,
        params: {
          "genre": genre,
        },
      );
      MoviesResponse result = MoviesResponse.fromJson(response.data);
      return result;
    } catch (e) {
      rethrow;
    }
  }
  //browse_movies
  @override
  Future<MoviesResponse> listLimitMoviesByGenre(String genre,int limit) async {
    try {
      var response = await api.getApi(
        YTSEndpoints.listMoviesEndpoint,
        params: {
          "genre": genre,
          "limit": limit,
        },
      );
      MoviesResponse result = MoviesResponse.fromJson(response.data);
      return result;
    } catch (e) {
      rethrow;
    }
  }


  //recent_movies
  @override
  Future<MoviesResponse> getRecentMovies() async {
    try {
      var response = await api.getApi(YTSEndpoints.listMoviesEndpoint, params: {
        "sort_by": "year",
        "order_by": "desc",
        "limit": 10,
      });
      MoviesResponse result = MoviesResponse.fromJson(response.data);
      return result;
    }catch(e){
      rethrow;
    }
  }



  /////////// Movie_Details
  //list_of_movies
  @override
  Future<List<MovieResponse>> getMoviesByIDs(List<int> ids) async {
    try {
      // var response = await api.getApi(
      //   YTSEndpoints.movieDetailsEndpoint,
      //   params: {"movie_id": id, "with_images": true, "with_cast": true},
      // );
      // MovieResponse result = MovieResponse.fromJson(response.data);
      // return result;
      final responses = await Future.wait(
        ids.map((id) => repo.getMovieByID(id)),
      );

      return responses;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MoviesResponse> getMovieSuggestionsById(int id) async {
    try {
      var response = await api.getApi(YTSEndpoints.movieSuggestionsEndpoint,
          params: {
            "movie_id": id
          }
      );
      MoviesResponse result = MoviesResponse.fromJson(response.data);
      return result;
    }catch(e){
      rethrow;
    }
  }

}