import '../../../../Core/Models/MoviesResponse.dart';
import '../Movies Details Repo/movie_details_repo.dart';

class GetMovieSuggestionsUC {
  final MovieDetailsRepo repo;
  GetMovieSuggestionsUC(this.repo);

  Future<MoviesResponse> call(int id) async {
    return await repo.getMovieSuggestionsById(id);
  }
}