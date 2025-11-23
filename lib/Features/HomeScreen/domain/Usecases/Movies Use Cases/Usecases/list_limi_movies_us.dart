import '../../../../../../Core/Models/MoviesResponse.dart';
import '../../../../data/Repo Implementation/movie_remote_repo_imp.dart';

class ListLimitMoviesByGenreUC {
  final MoviesRemoteRepository moviesRepo;
  ListLimitMoviesByGenreUC(this.moviesRepo);

  Future<MoviesResponse> call(String genre, int limit) {
    return moviesRepo.listLimitMoviesByGenre(genre, limit);
  }
}
