import 'package:injectable/injectable.dart';
import 'package:movie_app/Features/moviesDetails/domain/Use%20Cases/updateUserList_usecase.dart';
import 'package:movie_app/Features/moviesDetails/domain/Use%20Cases/watchMovieFromUrl_usecase.dart';

import '../Movies Details Repo/movie_details_repo.dart';

import 'getMovieByID_usecase.dart';

@injectable
class MovieDetailsUseCases {
  final GetMovieByIDUC getMovieByIDUC;
  final WatchMovieFromUrlUC watchMovieFromUrlUC;
  final UpdateUserListUC updateUserListUC;


  MovieDetailsUseCases(MovieDetailsRepo repo)
      : getMovieByIDUC = GetMovieByIDUC(repo),
        watchMovieFromUrlUC = WatchMovieFromUrlUC(repo),
        updateUserListUC = UpdateUserListUC(repo);
}

