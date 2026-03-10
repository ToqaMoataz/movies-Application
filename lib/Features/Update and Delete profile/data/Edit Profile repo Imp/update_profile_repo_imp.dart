
import 'package:injectable/injectable.dart';
import 'package:movie_app/Features/Update%20and%20Delete%20profile/data/Data%20Source/update_profile_datasource.dart';
import '../../domail/Edit Profile repo/update_profile_repo.dart';

@Injectable(as: UpdateProfileRepo)
class UpdateProfileRepoImp extends UpdateProfileRepo{
  final UpdateProfileDS ds;

  UpdateProfileRepoImp(this.ds);
  @override
  Future<void> updateUserData({required String name, required String phoneNumber, required String image,})async {
    try {
      await ds.updateUserData(name: name, phoneNumber: phoneNumber, image: image);
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<void> deleteUser() async {
    try {
      await ds.deleteUser();
    } catch (e) {
      rethrow;
    }
  }


}