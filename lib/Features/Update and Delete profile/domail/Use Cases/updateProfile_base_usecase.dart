import 'package:injectable/injectable.dart';
import 'package:movie_app/Features/Update%20and%20Delete%20profile/domail/Use%20Cases/use%20cases/deletUser_usecase.dart';
import 'package:movie_app/Features/Update%20and%20Delete%20profile/domail/Use%20Cases/use%20cases/updateuserdata_usecase.dart';

import '../Edit Profile repo/update_profile_repo.dart';

@injectable

class UpdateProfileUseCases {
  final UpdateUserDataUC updateUserDataUC;
  final DeleteUserUC deleteUserUC;

  UpdateProfileUseCases(UpdateProfileRepo repo)
      : updateUserDataUC = UpdateUserDataUC(repo),
        deleteUserUC = DeleteUserUC(repo);
}
