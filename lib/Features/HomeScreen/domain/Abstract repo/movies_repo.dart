
import '../../../../Core/Models/MoviesResponse.dart';
import '../../../../Core/Models/movie_model.dart';

abstract class MoviesRepository{
  Future<MoviesResponse> searchMovies(String movieName);
  Future<MoviesResponse> listMoviesByGenre(String genre);
  Future<MoviesResponse> listLimitMoviesByGenre(String genre,int limit);
  Future<MoviesResponse> getRecentMovies();
  Future<List<MovieResponse>> getMoviesByIDs(List<int> ids);
}