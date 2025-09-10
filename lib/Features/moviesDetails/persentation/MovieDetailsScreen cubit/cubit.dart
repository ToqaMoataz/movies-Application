import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Hive/hive_manager.dart';
import 'states.dart';
import '../../../../Core/Models/movie_model.dart';
import '../../domain/movie_details_repo.dart';
import '../../../../../../Core/Models/MoviesResponse.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  final MovieDetailsRepo repo;

  MovieDetailsCubit(this.repo) : super(MovieDetailsStates());

  static MovieDetailsCubit get(context) => BlocProvider.of(context);

  void toggleBookmark() {
    emit(state.copyWith(bookMarkTabbed: !state.bookMarkTabbed));
  }

  Future<void> getMovieById(int id) async {
    emit(state.copyWith(movieRequestState: RequestState.loading));
    try {
      final MovieResponse result = await repo.getMovieByID(id);
      emit(state.copyWith(
        movieResponse: result,
        movieRequestState: RequestState.success,
      ));
      await getMovieSuggestionsById(id);
    } catch (e) {
      emit(state.copyWith(movieRequestState: RequestState.error));
    }
  }

  Future<void> getMovieSuggestionsById(int id) async {
    emit(state.copyWith(suggestionsRequestState: RequestState.loading));
    try {
      final MoviesResponse suggestions = await repo.getMovieSuggestionsById(id);
      emit(state.copyWith(
        movieSuggestions: suggestions,
        suggestionsRequestState: RequestState.success,
      ));
    } catch (e) {
      emit(state.copyWith(suggestionsRequestState: RequestState.error));
    }
  }

  Future<void> goToWatchMovie(String url) async {
    try{
      emit(state.copyWith(watchMovieRequestState: RequestState.loading));
      await repo.watchMovieFromUrl(url);
      emit(state.copyWith(watchMovieRequestState: RequestState.success));
    }catch(e){
      emit(state.copyWith(watchMovieRequestState: RequestState.error));
    }
  }

  Future<void> addToList(String listName,int movieId,bool isAdd) async {
    try{
     await repo.updateUserList(listName,movieId,isAdd);
    }catch(e){
      print(e.toString());
    }
  }

}
