

abstract class MoviesDataSources<TMovies, TMovie> {
  Future<TMovies?> searchMovies(String movieName);

  Future<TMovies?> listMoviesByGenre(genre);

  Future<TMovies?> listLimitMoviesByGenre(dynamic genre, int limit);

  Future<TMovies?> getRecentMovies();

  Future<List<TMovie>?> getMoviesByIDs(List<int> ids);

}