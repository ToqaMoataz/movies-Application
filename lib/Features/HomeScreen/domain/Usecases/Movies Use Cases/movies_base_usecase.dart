import 'package:injectable/injectable.dart';
import 'package:movie_app/Features/HomeScreen/domain/Abstract%20repo/movies_repo.dart';
import 'package:movie_app/Features/HomeScreen/domain/Usecases/Movies%20Use%20Cases/Usecases/browse_movies_us.dart';
import 'Usecases/get_recent_movies_us.dart';
import 'Usecases/list_limi_movies_us.dart';
import 'Usecases/movies_list_us.dart';
import 'Usecases/search_movies_us.dart';
@injectable
class MoviesUseCases {
  final SearchMoviesUC searchMoviesUC;
  final GetRecentMoviesUC getRecentMoviesUC;
  final BrowseMoviesUC listMoviesByGenreUC;
  final ListLimitMoviesByGenreUC listLimitMoviesByGenreUC;
  final GetMoviesByIDsUC getMoviesByIDsUC;

  MoviesUseCases(MoviesRepository repo)
      : searchMoviesUC = SearchMoviesUC(repo),
        getRecentMoviesUC = GetRecentMoviesUC(repo),
        listMoviesByGenreUC = BrowseMoviesUC(repo),
        listLimitMoviesByGenreUC = ListLimitMoviesByGenreUC(repo),
        getMoviesByIDsUC = GetMoviesByIDsUC(repo);

}