import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../Core/Firebase/firebase_manager.dart';
import '../../../../Core/Models/user_model.dart';

class AuthDataSource{
  Future<void> addUser(UserModel user) async {
    try {
      var snapshot = FirebaseManager.usersCollection().doc(user.id);
      user.id = snapshot.id;
      await snapshot.set(user);
    }on FirebaseAuthException catch (e){
      rethrow;
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try{
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    }on FirebaseAuthException catch (e){
      rethrow;
    }

  }

  @override
  Future<void> register({required UserModel user, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      user.id = credential.user!.uid;
      await addUser(user);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch (e){
      rethrow;
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
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
    }on FirebaseAuthException catch (e){
      rethrow;
    }
  }
}

