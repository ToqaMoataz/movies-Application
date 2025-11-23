
import 'package:movie_app/Core/Models/user_model.dart';

import '../../../Abstract repo/user_repo.dart';

class CurrUserUC {
  final UserRepo repo;

  CurrUserUC(this.repo);

  Future<UserModel?> call(){
    return repo.readCurrUser();
  }
}
