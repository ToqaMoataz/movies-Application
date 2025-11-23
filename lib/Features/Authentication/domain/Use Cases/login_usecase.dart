

import '../../../../Core/Models/user_model.dart';
import '../Apstract Repo/repo.dart';

class LoginUseCase {
  AuthRepository repo;
  LoginUseCase(this.repo);

  Future<void> callLogin({required String email, required String password}) async {
    try{
      await repo.login(email: email, password: password);
    }catch(e){
      rethrow;
    }

  }

  Future<UserModel?> callLoginWithGoogle() async {
    try{
      UserModel? user=await repo.signInWithGoogle();
      return user;
    }catch(e){
      rethrow;
    }
  }

}