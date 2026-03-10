import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../Core/Firebase/firebase_manager.dart';
import '../../../../Core/Models/User/user_model.dart';

abstract class AuthDataSource {
  Future<void> addUser(UserModel user);
  Future<void> login({required String email, required String password});
  Future<void> register({required UserModel user, required String password,});
  Future<void> sendPasswordResetEmail(String email);
  Future<UserModel?> signInWithGoogle();
}

@Injectable(as: AuthDataSource)
class AuthDataSourceImp extends AuthDataSource {
  String getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found for this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak';
      case 'network-request-failed':
        return 'Check your internet connection';
      case 'invalid-credential':
        return 'Invalid login credentials';

      case 'account-exists-with-different-credential':
        return 'Account exists with different sign-in provider';

      case 'credential-already-in-use':
        return 'This credential is already linked to another account';
      default:
        return 'Something went wrong. Please try again';
    }
  }

  @override
  Future<void> addUser(UserModel user) async {
    try {
      var snapshot = FirebaseManager.usersCollection().doc(user.id);
      user.id = snapshot.id;
      await snapshot.set(user);
    } on FirebaseAuthException catch (e) {
     throw Exception(getAuthErrorMessage(e.code));
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(getAuthErrorMessage(e.code));
    }
  }

  @override
  Future<void> register({
    required UserModel user,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );
      user.id = credential.user!.uid;
      await addUser(user);
    } on FirebaseAuthException catch (e) {
      throw Exception(getAuthErrorMessage(e.code));
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(getAuthErrorMessage(e.code));
    }
  }
  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final user = userCredential.user!;

      final userModel = UserModel(
        id: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
        phoneNumber: user.phoneNumber ?? "",
        image: user.photoURL ?? "",
      );

      final docRef = FirebaseManager.usersCollection().doc(user.uid);
      final snapshot = await docRef.get();

      if (!snapshot.exists) {
        await docRef.set(userModel);
      }
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(getAuthErrorMessage(e.code));
    }
  }
}
