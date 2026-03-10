

import 'package:injectable/injectable.dart';

import '../../../../Core/Models/User/user_model.dart';
import '../Apstract Repo/repo.dart';
@injectable
class RegisterUseCase {
  AuthRepository repo;
  RegisterUseCase(this.repo);

  Future<void> callRegister({required UserModel user, required String password}) async {
    try{
      await repo.register(user: user, password: password);
    }catch(e){
     rethrow;
    }
  }
}