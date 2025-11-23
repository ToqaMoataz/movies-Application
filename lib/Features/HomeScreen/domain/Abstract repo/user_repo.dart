import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/Core/Firebase/firebase_manager.dart';
import 'package:movie_app/Features/HomeScreen/data/Data%20Source/user_data_sources.dart';
import 'package:movie_app/Features/HomeScreen/data/Data%20Source/user_data_sources_impl.dart';

import '../../../../Core/Models/user_model.dart';


abstract class UserRepo{
  Future<UserModel?> readCurrUser();

  Future<void> signOutUser();

}