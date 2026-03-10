import 'package:movie_app/Core/Entities/movie_entity.dart';
import 'package:movie_app/Core/Models/User/user_model.dart';

abstract class HomeStates {}

class HomeState extends HomeStates {
  int genreIndex;
  int currTabIndex;
  int generatedGenres;
  String? carouselBackgroundImg;
  UserModel? user;

  MoviesEntity? moviesSearchResponse;
  MoviesEntity? moviesBrowseResponse;
  MoviesEntity? recentMoviesResponse;

  List<Map<String, MoviesEntity>> moviesByGenreList;
  List<MovieSimpleEntity>? toWatchMoviesResponse;
  List<MovieSimpleEntity>? historyMoviesResponse;


  RequestState searchMoviesRequestState;
  RequestState browseMoviesRequestState;
  RequestState profileMoviesRequestState;
  RequestState recentMoviesRequestState;
  RequestState moviesByGenreRequestState;
  RequestState toWatchMoviesRequestState;
  RequestState historyMoviesRequestState;
  RequestState signOutRequestState;

  String? errorMessage;
  bool isVisible;

  HomeState({
    this.currTabIndex = 0,
    this.genreIndex = 0,
    this.generatedGenres = 0,
    this.carouselBackgroundImg,
    this.searchMoviesRequestState = RequestState.init,
    this.browseMoviesRequestState = RequestState.init,
    this.profileMoviesRequestState = RequestState.init,
    this.recentMoviesRequestState = RequestState.init,
    this.moviesByGenreRequestState = RequestState.init,
    this.toWatchMoviesRequestState = RequestState.init,
    this.historyMoviesRequestState = RequestState.init,
    this.signOutRequestState = RequestState.init,
    this.moviesSearchResponse,
    this.moviesBrowseResponse,
    this.recentMoviesResponse,
    this.moviesByGenreList = const [],
    this.toWatchMoviesResponse,
    this.historyMoviesResponse,
    this.errorMessage,
    this.user,
    this.isVisible = true,
  });

  HomeState copyWith({
    int? currTabIndex,
    int? genreIndex,
    int? generatedGenres,
    String? carouselBackgroundImg,
    RequestState? searchMoviesRequestState,
    RequestState? browseMoviesRequestState,
    RequestState? profileMoviesRequestState,
    RequestState? recentMoviesRequestState,
    RequestState? moviesByGenreRequestState,
    RequestState? toWatchMoviesRequestState,
    RequestState? historyMoviesRequestState,
    RequestState? signOutRequestState,
    MoviesEntity? moviesSearchResponse,
    MoviesEntity? moviesBrowseResponse,
    MoviesEntity? recentMoviesResponse,
    List<Map<String, MoviesEntity>>? moviesByGenreList,
    List<MovieSimpleEntity>? toWatchMoviesResponse,
    List<MovieSimpleEntity>? historyMoviesResponse,
    String? errorMessage,
    UserModel? user,
    bool? isVisible,
  }) {
    return HomeState(
      currTabIndex: currTabIndex ?? this.currTabIndex,
      genreIndex: genreIndex ?? this.genreIndex,
      generatedGenres: generatedGenres ?? this.generatedGenres,
      carouselBackgroundImg: carouselBackgroundImg ?? this.carouselBackgroundImg,
      searchMoviesRequestState: searchMoviesRequestState ?? this.searchMoviesRequestState,
      browseMoviesRequestState: browseMoviesRequestState ?? this.browseMoviesRequestState,
      profileMoviesRequestState: profileMoviesRequestState ?? this.profileMoviesRequestState,
      recentMoviesRequestState: recentMoviesRequestState ?? this.recentMoviesRequestState,
      moviesByGenreRequestState: moviesByGenreRequestState ?? this.moviesByGenreRequestState,
      toWatchMoviesRequestState: toWatchMoviesRequestState ?? this.toWatchMoviesRequestState,
      historyMoviesRequestState: historyMoviesRequestState ?? this.historyMoviesRequestState,
      signOutRequestState: signOutRequestState ?? this.signOutRequestState,
      moviesSearchResponse: moviesSearchResponse ?? this.moviesSearchResponse,
      moviesBrowseResponse: moviesBrowseResponse ?? this.moviesBrowseResponse,
      recentMoviesResponse: recentMoviesResponse ?? this.recentMoviesResponse,
      moviesByGenreList: moviesByGenreList ?? this.moviesByGenreList,
      toWatchMoviesResponse: toWatchMoviesResponse ?? this.toWatchMoviesResponse,
      historyMoviesResponse: historyMoviesResponse ?? this.historyMoviesResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

class HomeInitState extends HomeState {}

enum RequestState { init, loading, success, error }
