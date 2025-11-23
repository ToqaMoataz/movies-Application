import 'package:movie_app/Features/HomeScreen/data/Repo%20Implementation/movie_remote_repo_imp.dart';
import 'package:movie_app/Features/HomeScreen/domain/Usecases/Movies%20Use%20Cases/Usecases/browse_movies_us.dart';

import '../../../data/Data Source/movies_data_sources.dart';
import 'Usecases/get_recent_movies_us.dart';
import 'Usecases/list_limi_movies_us.dart';
import 'Usecases/movies_list_us.dart';
import 'Usecases/movies_suggestions_us.dart';
import 'Usecases/search_movies_us.dart';

class MoviesUseCases {
  final SearchMoviesUC searchMoviesUC;
  final GetRecentMoviesUC getRecentMoviesUC;
  final BrowseMoviesUC listMoviesByGenreUC;
  final ListLimitMoviesByGenreUC listLimitMoviesByGenreUC;
  final GetMoviesByIDsUC getMoviesByIDsUC;
  final GetMovieSuggestionsByIdUC getMovieSuggestionsByIdUC;

  MoviesUseCases(MoviesRemoteRepository repo)
      : searchMoviesUC = SearchMoviesUC(repo),
        getRecentMoviesUC = GetRecentMoviesUC(repo),
        listMoviesByGenreUC = BrowseMoviesUC(repo),
        listLimitMoviesByGenreUC = ListLimitMoviesByGenreUC(repo),
        getMoviesByIDsUC = GetMoviesByIDsUC(repo),
        getMovieSuggestionsByIdUC = GetMovieSuggestionsByIdUC(repo);
}