import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../Core/Firebase/firebase_manager.dart';

abstract class UpdateProfileRepo{
  Future<void> updateUserData({required String name, required String phoneNumber, required String image,});
  Future<void> deleteUser();
}

