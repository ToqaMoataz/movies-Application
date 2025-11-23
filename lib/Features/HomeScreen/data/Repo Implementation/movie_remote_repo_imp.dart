import 'package:movie_app/Features/HomeScreen/data/Data%20Source/movies_data_sources.dart';
import 'package:movie_app/Features/HomeScreen/domain/Abstract%20repo/movies_repo.dart';
import '../../../../Core/Models/MoviesResponse.dart';
import '../../../../Core/Models/movie_model.dart';



class MoviesRemoteRepository implements MoviesRepository{
  final MoviesDataSources moviesData;

  MoviesRemoteRepository(this.moviesData);

  @override
  Future<MoviesResponse> searchMovies(String movieName)  {
    try {
      var response =  moviesData.searchMovies(movieName);
      return response;
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<MoviesResponse> listMoviesByGenre(String genre)  {
    try {
      var response =  moviesData.listMoviesByGenre(genre);
      return response;
    } catch (e) {
      rethrow;
    }
  }
  //browse_movies
  @override
  Future<MoviesResponse> listLimitMoviesByGenre(String genre,int limit)  {
    try {
      var response = moviesData.listLimitMoviesByGenre(genre, limit);
      return response;
    } catch (e) {
      rethrow;
    }
  }


  //recent_movies
  @override
  Future<MoviesResponse> getRecentMovies() {
    try {
      var response = moviesData.getRecentMovies();
      return response;
    }catch(e){
      rethrow;
    }
  }



  /////////// Movie_Details
  //list_of_movies
  @override
  Future<List<MovieResponse>> getMoviesByIDs(List<int> ids){
    try {

      final responses = moviesData.getMoviesByIDs(ids);
      return responses;
    } catch (e) {
      rethrow;
    }
  }


  /////////// Movie_Suggestions
  Future<MoviesResponse> getMovieSuggestionsById(int id){
    try {
      var response =moviesData.getMovieSuggestionsById(id);
      return response;
    }catch(e){
      rethrow;
    }
  }



}