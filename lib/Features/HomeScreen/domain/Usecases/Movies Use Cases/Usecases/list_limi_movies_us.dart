import 'package:injectable/injectable.dart';
import 'package:movie_app/Core/Entities/movie_entity.dart';
import '../../../Abstract repo/movies_repo.dart';
@injectable
class ListLimitMoviesByGenreUC {
  final MoviesRepository moviesRepo;
  ListLimitMoviesByGenreUC(this.moviesRepo);

  Future<MoviesEntity?> call(dynamic genre, int limit) async {
    try{
      MoviesEntity? response=  await moviesRepo.listLimitMoviesByGenre(genre, limit);
      return response;
    }catch(e){
      rethrow;
    }

  }
}
