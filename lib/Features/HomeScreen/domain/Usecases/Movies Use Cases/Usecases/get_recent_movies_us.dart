import 'package:injectable/injectable.dart';
import 'package:movie_app/Core/Entities/movie_entity.dart';
import '../../../Abstract repo/movies_repo.dart';

@injectable
class GetRecentMoviesUC{
  final MoviesRepository moviesRepo;
  GetRecentMoviesUC(this.moviesRepo);

  Future<MoviesEntity?> call() async {
    try{
      MoviesEntity? response=await moviesRepo.getRecentMovies();
      return response;
    }catch(e){
      rethrow;
    }

  }
}
