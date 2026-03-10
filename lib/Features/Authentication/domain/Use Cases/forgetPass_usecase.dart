
import 'package:injectable/injectable.dart';

import '../Apstract Repo/repo.dart';
@injectable
class ForgetPasswordUseCase {
  AuthRepository repo;
  ForgetPasswordUseCase(this.repo);

  Future<void> callForgetPass(String email)async{
    try{
     await repo.sendPasswordResetEmail(email);
    }catch(e){
     rethrow;
    }
  }
}