

import '../../../../Core/Models/User/user_model.dart';


abstract class UserRepo{
  Future<UserModel?> readCurrUser();

  Future<void> signOutUser();

}