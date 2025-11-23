import '../../../../../../Core/Models/MoviesResponse.dart';
import '../../../../data/Repo Implementation/movie_remote_repo_imp.dart';


class GetRecentMoviesUC{
  final MoviesRemoteRepository moviesRepo;
  GetRecentMoviesUC(this.moviesRepo);

  Future<MoviesResponse> call() {
    return moviesRepo.getRecentMovies();
  }
}
