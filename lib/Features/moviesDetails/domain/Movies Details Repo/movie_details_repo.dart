import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/Core/Firebase/firebase_manager.dart';
import 'package:movie_app/Core/Hive/hive_manager.dart';
import 'package:movie_app/Core/Models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Core/APIs/api_manager.dart';
import '../../../../Core/APIs/endpoints.dart';
import '../../../../Core/Models/MoviesResponse.dart';
import '../../data/models/MovieParentalGuidesResponse.dart';
import '../../../../Core/Models/movie_model.dart';

abstract class MovieDetailsRepo {

  Future<MovieResponse> getMovieByID(int id);

  Future<MoviesResponse> getMovieSuggestionsById(int id);

  Future<MovieParentalGuidesResponse> getMovieParentalGuidesById(int id);

  Future<void> updateUserList(String listName,int id,bool isAdd);

  Future<void> watchMovieFromUrl(String url);
}

