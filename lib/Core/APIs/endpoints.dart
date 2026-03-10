
class YTSEndpoints{
  static const String movieDetailsEndpoint="/api/v2/movie_details.json";

  static const String listMoviesEndpoint="/api/v2/list_movies.json";

  static const String movieSuggestionsEndpoint="/api/v2/movie_suggestions.json";
}

class TMDBEndpoints{
  static const String searchMoviesEndpoint = "/search/movie";

  static const String listMoviesEndpoint = "/discover/movie";

  static const String listTopRatedMovies = "/movie/top_rated";

  static String getMovieScreenshotsEndpoint(int id) {
    return "/movie/$id/images";
  }

  static String getMovieCastEndpoint(int id) {
    return "/movie/$id/credits";
  }

  static String returnMovieSuggestionsEndpoint(int id) {
    return "/movie/$id/similar";
  }

  static String movieDetailsEndpoint(int id) {
    return "/movie/$id";
  }
}