import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/Core/Firebase/firebase_manager.dart';
import 'package:movie_app/Core/Hive/hive_manager.dart';
import 'package:movie_app/Core/Models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Core/APIs/api_manager.dart';
import '../../../Core/APIs/endpoints.dart';
import '../../../Core/Models/MoviesResponse.dart';
import '../data/models/MovieParentalGuidesResponse.dart';
import '../../../Core/Models/movie_model.dart';

abstract class MovieDetailsRepo {
  //get_Movie_by_id✅
  Future<MovieResponse> getMovieByID(int id);

  /////////// Movie_Suggestions ✅
  Future<MoviesResponse> getMovieSuggestionsById(int id);

  /////////// Movie_Parental_Guides
  Future<MovieParentalGuidesResponse> getMovieParentalGuidesById(int id);

  Future<void> updateUserList(String listName,int id,bool isAdd);

  Future<void> watchMovieFromUrl(String url);
}

class MovieDetailsRepoImp extends MovieDetailsRepo {
  ApiManager api = ApiManager();

  @override
  //get_Movie_by_id✅
  Future<MovieResponse> getMovieByID(int id) async {
    try {
      var response = await api.getApi(
        Endpoints.movieDetailsEndpoint,
        params: {"movie_id": id, "with_images": true, "with_cast": true},
      );
      MovieResponse result = MovieResponse.fromJson(response.data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  /////////// Movie_Suggestions ✅
  Future<MoviesResponse> getMovieSuggestionsById(int id) async {
    try {
      var response = await api.getApi(
        Endpoints.movieSuggestionsEndpoint,
        params: {"movie_id": id},
      );
      MoviesResponse result = MoviesResponse.fromJson(response.data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> watchMovieFromUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $uri');
    }
  }
  //update watch List and history
  @override
  Future<void> updateUserList(String listName, int id,bool isAdd) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;
    final docRef = FirebaseManager.usersCollection().doc(userId);
    final snapshot = await docRef.get();
    if (!snapshot.exists) {
      return;
    }
    UserModel? user = snapshot.data();
    if (user == null) return;
    List<int> currentList;
    if (listName == "history") {
      currentList = List.from(user.historyList ?? []);
      await HiveManager.addToList("history", id);
    } else if (listName == "toWatchList") {
      currentList = List.from(user.toWatchList ?? []);
      await HiveManager.addToList("toWatchList", id);
    } else {
      return;
    }
    if (isAdd) {
      if (!currentList.contains(id)) {
        currentList.add(id);
      }
    } else {
      currentList.remove(id);
      await HiveManager.removeFromToWatchList(id);
    }
    await docRef.update({listName: currentList});
    print("✅ $listName updated → $currentList");
  } on FirebaseAuthException catch (e) {
    rethrow;
  }
}


  /////////// Movie_Parental_Guides
  @override
  Future<MovieParentalGuidesResponse> getMovieParentalGuidesById(int id) async {
    try {
      var response = await api.getApi(Endpoints.movieParentalGuidesEndpoint,
          params: {
            "movie_id": id
          }
      );
      MovieParentalGuidesResponse result = MovieParentalGuidesResponse.fromJson(
          response.data);
      return result;
    }catch(e){
      rethrow;
    }
  }
}
