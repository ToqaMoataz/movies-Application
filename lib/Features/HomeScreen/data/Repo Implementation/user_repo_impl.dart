
import 'package:injectable/injectable.dart';

import '../../../../Core/Models/User/user_model.dart';
import '../../domain/Abstract repo/user_repo.dart';
import '../Data Source/user_data_sources.dart';
@LazySingleton(as: UserRepo)
class UserRepoImpl extends UserRepo {
  final UserDataSources userData;

  UserRepoImpl(this.userData);
  @override
  Future<UserModel?> readCurrUser() async {
    try {
      UserModel? user = await userData.readCurrUser();
      return user;
    }catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOutUser() async {
    try {
      await userData.signOutUser();
    } catch (e) {
      rethrow;
    }
  }
}