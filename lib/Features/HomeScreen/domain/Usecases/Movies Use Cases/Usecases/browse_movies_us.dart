

import '../../../../../../Core/Models/MoviesResponse.dart';
import '../../../../data/Repo Implementation/movie_remote_repo_imp.dart';


class BrowseMoviesUC{
  final MoviesRemoteRepository moviesRepo;
  BrowseMoviesUC(this.moviesRepo);

  Future<MoviesResponse> call(String genre) {
    return moviesRepo.listMoviesByGenre(genre);
  }
}
