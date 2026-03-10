
import 'package:movie_app/Core/Entities/movie_entity.dart';



abstract class MoviesRepository{
  Future<MoviesEntity?> searchMovies(String movieName);
  Future<MoviesEntity?> listMoviesByGenre(String genre);
  Future<MoviesEntity?> listLimitMoviesByGenre(dynamic
  genre,int limit);
  Future<MoviesEntity?> getRecentMovies();
  Future<List<MovieSimpleEntity>?> getMoviesByIDs(List<int> ids);
  // Future<List<MovieSimpleEntity>?> getMovieSuggestionsById(int id);
}