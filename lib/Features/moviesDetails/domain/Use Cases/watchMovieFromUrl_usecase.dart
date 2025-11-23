import '../Movies Details Repo/movie_details_repo.dart';

class WatchMovieFromUrlUC {
  final MovieDetailsRepo repo;
  WatchMovieFromUrlUC(this.repo);

  Future<void> call(String url) async {
    return await repo.watchMovieFromUrl(url);
  }
}