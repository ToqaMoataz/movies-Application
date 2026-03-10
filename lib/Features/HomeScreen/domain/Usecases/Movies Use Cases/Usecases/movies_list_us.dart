import 'package:injectable/injectable.dart';

import '../../../../../../Core/Entities/movie_entity.dart';
import '../../../../data/Repo Implementation/movie_remote_repo_imp.dart';
import '../../../Abstract repo/movies_repo.dart';
@injectable
class GetMoviesByIDsUC {
  final MoviesRepository moviesRepo;
  GetMoviesByIDsUC(this.moviesRepo);

  Future<List<MovieSimpleEntity>?> call(List<int> ids) async {
    try{
      List<MovieSimpleEntity>? response = await moviesRepo.getMoviesByIDs(ids);
      return response;
    }catch(e){
      rethrow;
    }

  }
}
