import '../../../../../../Core/Models/MoviesResponse.dart';
import '../../../../data/Repo Implementation/movie_remote_repo_imp.dart';


class SearchMoviesUC {
  final MoviesRemoteRepository moviesRepo;

  SearchMoviesUC(this.moviesRepo);

  Future<MoviesResponse> call(String movieName) async {
    return await moviesRepo.searchMovies(movieName);
  }
}
