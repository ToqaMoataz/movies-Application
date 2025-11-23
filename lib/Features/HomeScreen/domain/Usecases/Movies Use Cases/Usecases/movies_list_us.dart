import '../../../../../../Core/Models/movie_model.dart';
import '../../../../data/Repo Implementation/movie_remote_repo_imp.dart';

class GetMoviesByIDsUC {
  final MoviesRemoteRepository moviesRepo;
  GetMoviesByIDsUC(this.moviesRepo);

  Future<List<MovieResponse>> call(List<int> ids) {
    return moviesRepo.getMoviesByIDs(ids);
  }
}
