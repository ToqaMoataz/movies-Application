
import 'package:movie_app/Features/moviesDetails/data/Data%20Sources/dataSource.dart';
import '../../../../Core/Models/MoviesResponse.dart';
import '../models/MovieParentalGuidesResponse.dart';
import '../../../../Core/Models/movie_model.dart';
import '../../domain/Movies Details Repo/movie_details_repo.dart';


class MovieDetailsRepoImp extends MovieDetailsRepo {
  final MoviesDetailsDs moviesDetailsDs;
  MovieDetailsRepoImp(this.moviesDetailsDs);
  @override
  Future<MovieResponse> getMovieByID(int id){
    try {
      var response = moviesDetailsDs.getMovieByID(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  /////////// Movie_Suggestions ✅
  Future<MoviesResponse> getMovieSuggestionsById(int id) {
    try {
      var response = moviesDetailsDs.getMovieSuggestionsById(id);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> watchMovieFromUrl(String url) async {
    try {
      await moviesDetailsDs.watchMovieFromUrl(url);
    } catch (e) {
      rethrow;
    }
  }
  //update watch List and history
  @override
  Future<void> updateUserList(String listName, int id,bool isAdd) async {
  try {
    moviesDetailsDs.updateUserList(listName, id, isAdd);
  }catch (e) {
    rethrow;
  }
}


  /////////// Movie_Parental_Guides
  @override
  Future<MovieParentalGuidesResponse> getMovieParentalGuidesById(int id) async {
    try {
      var response =moviesDetailsDs.getMovieParentalGuidesById(id);
      return response;
    }catch(e){
      rethrow;
    }
  }
}
