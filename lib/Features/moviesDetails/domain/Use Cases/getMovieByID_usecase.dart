import 'package:injectable/injectable.dart';

import '../../../../Core/Entities/movie_entity.dart';

import '../Movies Details Repo/movie_details_repo.dart';
@injectable
class GetMovieByIDUC {
  final MovieDetailsRepo repo;
  GetMovieByIDUC(this.repo);

  Future<MovieEntity> call(int id) async {
    try{
      MovieEntity movie= await repo.getMovieByID(id);
      return movie;
    }catch(e){
      rethrow;
    }

  }
}