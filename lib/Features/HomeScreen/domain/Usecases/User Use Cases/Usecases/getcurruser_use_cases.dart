
import 'package:injectable/injectable.dart';
import 'package:movie_app/Core/Models/User/user_model.dart';

import '../../../Abstract repo/user_repo.dart';
@injectable
class CurrUserUC {
  final UserRepo repo;

  CurrUserUC(this.repo);

  Future<UserModel?> call(){
    return repo.readCurrUser();
  }
}
