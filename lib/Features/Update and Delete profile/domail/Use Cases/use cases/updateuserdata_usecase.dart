import '../../Edit Profile repo/update_profile_repo.dart';

class UpdateUserDataUC {
  final UpdateProfileRepo repo;

  UpdateUserDataUC(this.repo);

  Future<void> call({
    required String name,
    required String phoneNumber,
    required String image,
  }) async {
    return await repo.updateUserData(
      name: name,
      phoneNumber: phoneNumber,
      image: image,
    );
  }
}