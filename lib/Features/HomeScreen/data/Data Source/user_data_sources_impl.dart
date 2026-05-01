
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Features/HomeScreen/data/Data%20Source/user_data_sources.dart';

import '../../../../Core/Firebase/firebase_manager.dart';
import '../../../../Core/Models/User/user_model.dart';
@LazySingleton(as: UserDataSources)
class UserDataSourcesImpl extends UserDataSources{
  @override
  Future<UserModel?> readCurrUser() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      final docRef = FirebaseManager.usersCollection().doc(uid);
      final snapshot = await docRef.get();
      final user = snapshot.data();
      return user;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  @override
  Future<void> signOutUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      GoogleSignIn googleSignIn = GoogleSignIn();
      if (user == null) {
        return;
      }

      bool isGoogleUser = user.providerData.any((provider) => provider.providerId == 'google.com');

      if (isGoogleUser) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();

    } catch (e) {
      rethrow;
    }
  }
}