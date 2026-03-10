import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Core/Entities/movie_entity.dart';
import '../../domain/Use Cases/moviesDetails_usecases.dart';
import 'states.dart';

@injectable
class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  final MovieDetailsUseCases useCases;
  MovieDetailsCubit(this.useCases) : super(MovieDetailsStates());

  static MovieDetailsCubit get(context) => BlocProvider.of(context);

  void toggleBookmark() {
    emit(state.copyWith(bookMarkTabbed: !state.bookMarkTabbed));
  }

  Future<void> getMovieById(int id) async {
    print("ID: $id");
    emit(state.copyWith(movieRequestState: RequestState.loading));
    try {
      final MovieEntity result = await useCases.getMovieByIDUC.call(id);
      emit(state.copyWith(
        movieResponse: result,
        movieRequestState: RequestState.success,
      ));
    } catch (e) {
      print("Error message: ${e.toString()}");
      emit(state.copyWith(movieRequestState: RequestState.error));
    }
  }

  // Future<void> getMovieSuggestionsById(int id) async {
  //   emit(state.copyWith(suggestionsRequestState: RequestState.loading));
  //   try {
  //     final MoviesEntity suggestions = await useCases.getMovieSuggestionsUC.call(id);
  //     emit(state.copyWith(
  //       movieSuggestions: suggestions,
  //       suggestionsRequestState: RequestState.success,
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(suggestionsRequestState: RequestState.error));
  //   }
  // }




  Future<void> goToWatchMovie(String url) async {
    try{
      emit(state.copyWith(watchMovieRequestState: RequestState.loading));
     await useCases.watchMovieFromUrlUC.call(url);
      emit(state.copyWith(watchMovieRequestState: RequestState.success));
    }catch(e){
      emit(state.copyWith(watchMovieRequestState: RequestState.error));
    }
  }

  Future<void> addToList(String listName,int movieId,bool isAdd)async{
    try{
     await useCases.updateUserListUC.call(listName,movieId,isAdd);
    }catch(e){
      print(e.toString());
    }
  }

}
