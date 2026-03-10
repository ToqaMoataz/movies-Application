import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../Core/Firebase/firebase_manager.dart';


abstract class UpdateProfileDS{
  Future<void> updateUserData({required String name, required String phoneNumber, required String image,});
  Future<void> deleteUser();
}

@Injectable(as: UpdateProfileDS)
class UpdateProfileDSImp extends UpdateProfileDS{
  @override
  Future<void> updateUserData({required String name, required String phoneNumber, required String image,}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return;
      }

      final doc = await FirebaseManager.usersCollection().doc(user.uid).get();
      if (!doc.exists) {
        return;
      }

      final currentUser = doc.data()!;

      if (currentUser.name != name || currentUser.phoneNumber != phoneNumber ||  currentUser.image != image) {
        await FirebaseManager.usersCollection().doc(user.uid).update({
          'name': name,
          'phoneNumber': phoneNumber,
          'image': image,
        });
      } else {
        return;
      }
    } on FirebaseException catch (e) {
      throw Exception("Failed to update user: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }


  @override
  Future<void> deleteUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    await FirebaseFirestore.instance.collection("Users").doc(user.uid).delete();
    await user.delete();
  }
}