import '../../../../Core/Models/user_model.dart';

abstract class UserDataSources{
  Future<UserModel?> readCurrUser();

  Future<void> signOutUser();
}