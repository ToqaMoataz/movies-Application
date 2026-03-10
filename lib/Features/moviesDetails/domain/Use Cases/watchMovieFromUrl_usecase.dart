import 'package:injectable/injectable.dart';

import '../Movies Details Repo/movie_details_repo.dart';
@injectable
class WatchMovieFromUrlUC {
  final MovieDetailsRepo repo;
  WatchMovieFromUrlUC(this.repo);

  Future<void> call(String url) async {
    try{
      await repo.watchMovieFromUrl(url);
    }catch(e){
      rethrow;
    }

  }
}