import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/User/user_model.dart';

class FirebaseManager {
  //Users//
  static CollectionReference<UserModel> usersCollection() {
    return FirebaseFirestore.instance.collection("Users").withConverter(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!, id: snapshot.id);
      },
      toFirestore: (model, _) {
        return model.toJson();
      },
    );
  }
}


