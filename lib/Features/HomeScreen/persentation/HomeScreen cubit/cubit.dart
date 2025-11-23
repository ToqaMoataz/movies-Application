import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Core/Models/movie_model.dart';
import 'package:movie_app/Core/Models/user_model.dart';
import 'package:movie_app/Features/HomeScreen/domain/Usecases/Movies%20Use%20Cases/movies_base_usecase.dart';
import 'package:movie_app/Features/HomeScreen/domain/Usecases/User%20Use%20Cases/user_base_usecase.dart';
import 'package:movie_app/Features/HomeScreen/persentation/HomeScreen cubit/state.dart';

import '../../../../Core/Models/MoviesResponse.dart';
import '../../data/Data Source/local_data.dart';
import '../../domain/Abstract repo/movies_repo.dart';
import '../../domain/Abstract repo/user_repo.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.moviesUseCases, this.userUsecases) : super(HomeInitState());
  final MoviesUseCases moviesUseCases;
  final UserUseCases userUsecases;
  // final MoviesRepository repo;
  // final UserRepo userRepo;
  final genres = AppData.getMoviesGenres();

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  // 🔹 Carousel index + background
  void setCarouselIndex(int index, String img) {
    emit(state.copyWith(carouselBackgroundImg: img));
    if (index == 2) {
      browseByGenre();
    }
  }

  // 🔹 Set main tab index
  void setTabIndex(int index) {
    emit(state.copyWith(currTabIndex: index));
    if (index == 2) {
      browseByGenre();
    } else if (index == 3) {
      getCurrentUser();
    }
  }

  // 🔹 Set genre tab index
  void setGenreTabIndex(int index) {
    emit(state.copyWith(genreIndex: index));
    browseByGenre();
  }

  // ================= HOME TAB =================
  Future<void> loadHomeTab() async {
    try {
      emit(state.copyWith(recentMoviesRequestState: RequestState.loading));
      final recentResponse =await moviesUseCases.getRecentMoviesUC.call();
      emit(state.copyWith(
        recentMoviesRequestState: RequestState.success,
        recentMoviesResponse:recentResponse,
      ));
    } catch (e) {
      emit(state.copyWith(
        recentMoviesRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getLimitedMoviesByGenre() async {
    try {
      emit(state.copyWith(moviesByGenreRequestState: RequestState.loading));

      final updatedList = <Map<String, MoviesResponse>>[];

      for (final genre in genres) {
        final response = await moviesUseCases.listLimitMoviesByGenreUC.call(genre,5);
        final movies = response.data?.movies;
        final limitedMovies = movies ?? <Movies>[];

        final limitedResponse = MoviesResponse(
          data: Data(
            movieCount: limitedMovies.length,
            movies: limitedMovies,
          ),
          meta: response.meta,
        );

        updatedList.add({genre: limitedResponse});
      }

      emit(state.copyWith(
        moviesByGenreRequestState: RequestState.success,
        moviesByGenreList: updatedList,
      ));
    } catch (e) {
      emit(state.copyWith(
        moviesByGenreRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }


  // ================= SEARCH TAB =================
  Future<void> searchMoviesByName(String search) async {
    try {
      emit(state.copyWith(searchMoviesRequestState: RequestState.loading));
      final response = await moviesUseCases.searchMoviesUC.call(search);
      emit(state.copyWith(
        searchMoviesRequestState: RequestState.success,
        moviesSearchResponse: response,
      ));
    } catch (e) {
      emit(state.copyWith(
        searchMoviesRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void clearSearch() {
    emit(state.copyWith(
      moviesSearchResponse: null,
      searchMoviesRequestState: RequestState.init,
    ));
  }

  // ================= BROWSE TAB =================
  Future<void> browseByGenre({String? genre}) async {
    try {
      emit(state.copyWith(browseMoviesRequestState: RequestState.loading));
      final response;
      if(genre==null){
        response = await moviesUseCases.listMoviesByGenreUC.call(genres[state.genreIndex]);
      }
      else{response = await moviesUseCases.listMoviesByGenreUC.call(genre);}
      emit(state.copyWith(
        browseMoviesRequestState: RequestState.success,
        moviesBrowseResponse: response,
      ));
    } catch (e) {
      emit(state.copyWith(
        browseMoviesRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ================= PROFILE TAB =================
  void toggleVisibility() {
    emit(state.copyWith(isVisible: !state.isVisible));
  }

  Future<void> getCurrentUser() async {
    try {
      emit(state.copyWith(profileMoviesRequestState: RequestState.loading));
      if (FirebaseAuth.instance.currentUser != null) {
        UserModel? response = await userUsecases.currUserUC.call();
        await returnHistoryList(response?.historyList);
        await returnToWatchList(response?.toWatchList);
        emit(state.copyWith(
          profileMoviesRequestState: RequestState.success,
          user: response,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        profileMoviesRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> returnHistoryList(List<int>? moviesIds) async {
    try {
      emit(state.copyWith(historyMoviesRequestState: RequestState.loading));
      List<MovieResponse>? movies = await moviesUseCases.getMoviesByIDsUC.call(moviesIds ?? []);
      emit(state.copyWith(
        historyMoviesResponse: movies,
        historyMoviesRequestState: RequestState.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        historyMoviesRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> returnToWatchList(List<int>? moviesIds) async {
    try {
      emit(state.copyWith(toWatchMoviesRequestState: RequestState.loading));
      List<MovieResponse>? movies = await moviesUseCases.getMoviesByIDsUC.call(moviesIds ?? []);
      emit(state.copyWith(
        toWatchMoviesResponse: movies,
        toWatchMoviesRequestState: RequestState.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        toWatchMoviesRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> signOut() async {
    try {
      emit(state.copyWith(signOutRequestState: RequestState.loading));
      await userUsecases.signOutUC.call();
      emit(state.copyWith(signOutRequestState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(
        signOutRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
