import '../../Edit Profile repo/update_profile_repo.dart';

class DeleteUserUC {
  final UpdateProfileRepo repo;

  DeleteUserUC(this.repo);

  Future<void> call() async {
    return await repo.deleteUser();
  }
}