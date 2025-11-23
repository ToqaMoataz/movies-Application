
import '../../Abstract repo/user_repo.dart';
import 'Usecases/getcurruser_use_cases.dart';
import 'Usecases/signout_use_cases.dart';


class UserUseCases {
  final CurrUserUC currUserUC;
  final SignOutUC signOutUC;

  UserUseCases(UserRepo repo)
      : currUserUC = CurrUserUC(repo),
        signOutUC = SignOutUC(repo);
}
