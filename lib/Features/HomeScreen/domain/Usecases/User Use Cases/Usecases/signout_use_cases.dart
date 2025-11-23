
import '../../../Abstract repo/user_repo.dart';

class SignOutUC {
  final UserRepo repo;

  SignOutUC(this.repo);

  Future<void> call(){
    return repo.signOutUser();
  }
}
