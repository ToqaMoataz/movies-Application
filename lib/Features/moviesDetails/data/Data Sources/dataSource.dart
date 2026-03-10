import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Core/APIs/api_manager.dart';
import '../../../../Core/APIs/endpoints.dart';
import '../../../../Core/Firebase/firebase_manager.dart';
import '../../../../Core/Hive/hive_manager.dart';
import '../../../../Core/Models/Movie/TMBD Response Models/tmbd_movie_images.dart';
import '../../../../Core/Models/Movie/TMBD Response Models/tmbd_similar_response.dart';
import '../../../../Core/Models/Movie/TMBD Response Models/tmdb_movie_cast.dart';
import '../../../../Core/Models/Movie/TMBD Response Models/tmdb_movie_details_response.dart';
import '../../../../Core/Models/Movie/TMBD Response Models/tmdb_movies_response_model.dart';
import '../../../../Core/Models/Movie/YTS  Response Models/yts_movie_response.dart';
import '../../../../Core/Models/Movie/YTS  Response Models/yts_movies_response.dart';
import '../../../../Core/Models/User/user_model.dart';


abstract class MoviesDetailsDs<TMovie,TMovies>{
  Future<TMovie> getMovieByID(int id);

  Future<void> updateUserList(String listName,int id,bool isAdd);

  Future<void> watchMovieFromUrl(String url);

  Future<TMovies> getMovieSuggestionsById(int id);
}

@Named("tmdbDetailsDS")
@LazySingleton()
class MoviesDetailsTMBDImpDs extends MoviesDetailsDs<TmdbMovieDetailsModel,TMDBMovieResponse>{
  ApiManager api;
  MoviesDetailsTMBDImpDs(this.api);

  Future<List<String>?> getMovieImages(int id) async {
    try {
      var response = await api.getApi(TMDBEndpoints.getMovieScreenshotsEndpoint(id),params:{"page":1} );
      MovieImagesResponse result=MovieImagesResponse.fromJson(response.data);
      List<MovieImage> backdrops = result.backdrops;

      List<String> screenshots = backdrops.map((image) => "https://image.tmdb.org/t/p/w780${image.filePath}").toList();

      return screenshots.take(5).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CastResponse>> getMovieCast(int id) async {
    try {
      var response = await api.getApi(TMDBEndpoints.getMovieCastEndpoint(id));
      MovieCreditsResponse result=MovieCreditsResponse.fromJson(response.data);
      List<CastResponse> cast=result.cast;

      return cast;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TmdbMovieDetailsModel> getMovieByID(int id) async {
    try {
      var response = await api.getApi(
        TMDBEndpoints.movieDetailsEndpoint(id),
      );
      TmdbMovieDetailsModel result = TmdbMovieDetailsModel.fromJson(response.data);
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
    }catch (e) {
      rethrow;
    }
  }

  @override
  Future<TMDBMovieResponse> getMovieSuggestionsById(int id) async {
    try {
      var response = await api.getApi(
        TMDBEndpoints.returnMovieSuggestionsEndpoint(id),
        params: {"movie_id": id,"page":1},
      );
      SimilarMoviesResponse result = SimilarMoviesResponse.fromJson(response.data);

      return TMDBMovieResponse(
        page: result.page ?? 1,
        results: result.results?.take(6).toList() ?? [],
        totalPages: 1,
        totalResults: result.results?.length ?? 0,
      );
    } catch (e) {
      rethrow;
    }
  }

}

@LazySingleton()
@Named("ytsDetailsDS")
class MoviesDetailsYTSImpDs extends MoviesDetailsDs<MovieResponse,MoviesResponse>{
  ApiManager api;
  MoviesDetailsYTSImpDs(this.api);

  @override
  Future<MovieResponse> getMovieByID(int id) async {
    try {
      var response = await api.getApi(
        YTSEndpoints.movieDetailsEndpoint,
        params: {"movie_id": id, "with_images": true, "with_cast": true},
      );
      MovieResponse result = MovieResponse.fromJson(response.data);
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
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MoviesResponse> getMovieSuggestionsById(int id) async {
    try {
      var response = await api.getApi(
        YTSEndpoints.movieSuggestionsEndpoint,
        params: {"movie_id": id},
      );
      MoviesResponse result = MoviesResponse.fromJson(response.data);
      return result;
    } catch (e) {
      rethrow;
    }
  }


}