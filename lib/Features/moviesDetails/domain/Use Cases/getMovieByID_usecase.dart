import '../../../../Core/Models/movie_model.dart';
import '../Movies Details Repo/movie_details_repo.dart';

class GetMovieByIDUC {
  final MovieDetailsRepo repo;
  GetMovieByIDUC(this.repo);

  Future<MovieResponse> call(int id) async {
    return await repo.getMovieByID(id);
  }
}