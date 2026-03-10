import 'package:injectable/injectable.dart';

import '../Movies Details Repo/movie_details_repo.dart';
@injectable
class UpdateUserListUC {
  final MovieDetailsRepo repo;
  UpdateUserListUC(this.repo);

  Future<void> call(String listName, int id, bool isAdd) async {
    try{
      await repo.updateUserList(listName, id, isAdd);
    }catch(e){
      rethrow;
    }

  }
}