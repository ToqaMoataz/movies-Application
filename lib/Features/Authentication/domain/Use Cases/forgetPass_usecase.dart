
import '../Apstract Repo/repo.dart';

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