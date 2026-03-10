import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../Core/Firebase/firebase_manager.dart';
import '../../../../Core/Models/User/user_model.dart';


abstract class AuthRepository{

  Future<void> sendPasswordResetEmail(String email);
  Future<UserModel?> signInWithGoogle();
  Future<void> login({required String email,required String password});
  Future<void> register({required UserModel user, required String password});
}




