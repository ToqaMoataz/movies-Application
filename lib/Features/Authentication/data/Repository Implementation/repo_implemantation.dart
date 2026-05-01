import 'package:injectable/injectable.dart';
import 'package:movie_app/Features/Authentication/data/data%20source/data%20source.dart';
import '../../../../Core/Models/User/user_model.dart';
import '../../domain/Apstract Repo/repo.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImplementation implements AuthRepository{
  final AuthDataSource dataSource;

  AuthRepositoryImplementation( this.dataSource);

  @override
  Future<void> login({required String email, required String password}) async {
    try{
      await dataSource.login(email: email, password: password);
    }catch (e){
      rethrow;
    }

  }

  @override
  Future<void> register({required UserModel user, required String password}) async {
    try {
      await dataSource.register(user: user, password: password);
    }catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await dataSource.sendPasswordResetEmail(email);
    }catch (e){
      rethrow;
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try{
      UserModel? user=await dataSource.signInWithGoogle();
      return user;
    }catch (e){
      rethrow;
    }


  }

}