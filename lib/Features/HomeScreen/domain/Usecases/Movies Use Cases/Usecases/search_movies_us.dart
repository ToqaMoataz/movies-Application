import 'package:injectable/injectable.dart';
import 'package:movie_app/Core/Entities/movie_entity.dart';

import '../../../../data/Repo Implementation/movie_remote_repo_imp.dart';
import '../../../Abstract repo/movies_repo.dart';

@injectable
class SearchMoviesUC {
  final MoviesRepository moviesRepo;

  SearchMoviesUC(this.moviesRepo);

  Future<MoviesEntity?> call(String movieName) async {
    try{
      MoviesEntity? response= await moviesRepo.searchMovies(movieName);
      return response;
    }catch(e){
      rethrow;
    }

  }
}
