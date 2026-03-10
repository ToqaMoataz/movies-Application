import 'package:injectable/injectable.dart';

import '../../Edit Profile repo/update_profile_repo.dart';
@injectable
class DeleteUserUC {
  final UpdateProfileRepo repo;

  DeleteUserUC(this.repo);

  Future<void> call() async {
    return await repo.deleteUser();
  }
}