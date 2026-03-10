
import 'package:injectable/injectable.dart';

import '../../../Abstract repo/user_repo.dart';
@injectable
class SignOutUC {
  final UserRepo repo;

  SignOutUC(this.repo);

  Future<void> call(){
    return repo.signOutUser();
  }
}
