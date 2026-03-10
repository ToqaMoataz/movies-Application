
import 'package:injectable/injectable.dart';

import '../../../../../../Core/Entities/movie_entity.dart';

import '../../../Abstract repo/movies_repo.dart';

@injectable
class BrowseMoviesUC{
  final MoviesRepository moviesRepo;
  BrowseMoviesUC(this.moviesRepo);

  Future<MoviesEntity?> call(dynamic genre) async {
    try{
      MoviesEntity? response=await moviesRepo.listMoviesByGenre(genre);
      return response;
    }catch(e){
      rethrow;
    }

  }
}
