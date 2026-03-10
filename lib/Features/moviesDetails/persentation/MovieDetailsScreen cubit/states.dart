import 'package:movie_app/Core/Entities/movie_entity.dart';


enum RequestState { init, loading, success, error }

class MovieDetailsStates {
  final bool bookMarkTabbed;
  final RequestState tabIconState;

  final RequestState movieRequestState;

  final RequestState watchMovieRequestState;

  final MovieEntity? movieResponse;


  MovieDetailsStates({
    this.bookMarkTabbed = false,
    this.tabIconState = RequestState.init,
    this.movieRequestState = RequestState.init,

    this.watchMovieRequestState = RequestState.init,
    this.movieResponse,

  });

  MovieDetailsStates copyWith({
    bool? bookMarkTabbed,
    RequestState? tabIconState,
    RequestState? movieRequestState,
    RequestState? suggestionsRequestState,
    RequestState? watchMovieRequestState,
    MovieEntity? movieResponse,
    MoviesEntity? movieSuggestions,
  }) {
    return MovieDetailsStates(
      bookMarkTabbed: bookMarkTabbed ?? this.bookMarkTabbed,
      tabIconState: tabIconState ?? this.tabIconState,
      movieRequestState: movieRequestState ?? this.movieRequestState,

      watchMovieRequestState:
      watchMovieRequestState ?? this.watchMovieRequestState,
      movieResponse: movieResponse ?? this.movieResponse,

    );
  }
}