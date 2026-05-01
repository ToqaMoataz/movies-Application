

abstract class UpdateProfileRepo{
  Future<void> updateUserData({required String name, required String phoneNumber, required String image,});
  Future<void> deleteUser();
}

