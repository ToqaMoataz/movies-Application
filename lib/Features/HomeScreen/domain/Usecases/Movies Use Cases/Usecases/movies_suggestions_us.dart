import '../../../../../../Core/Models/MoviesResponse.dart';
import '../../../../data/Repo Implementation/movie_remote_repo_imp.dart';

class GetMovieSuggestionsByIdUC {
  final MoviesRemoteRepository moviesRepo;

  GetMovieSuggestionsByIdUC(this.moviesRepo);

  Future<MoviesResponse> call(int id) async {
    return await moviesRepo.getMovieSuggestionsById(id);
  }
}


