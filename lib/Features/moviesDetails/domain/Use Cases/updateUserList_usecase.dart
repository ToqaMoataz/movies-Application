import '../Movies Details Repo/movie_details_repo.dart';

class UpdateUserListUC {
  final MovieDetailsRepo repo;
  UpdateUserListUC(this.repo);

  Future<void> call(String listName, int id, bool isAdd) async {
    return await repo.updateUserList(listName, id, isAdd);
  }
}