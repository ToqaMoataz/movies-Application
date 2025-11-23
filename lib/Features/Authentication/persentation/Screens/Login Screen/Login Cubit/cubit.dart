

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Features/Authentication/persentation/Screens/Login%20Screen/Login%20Cubit/states.dart';

import '../../../../../../Core/Models/user_model.dart';
import '../../../../domain/Use Cases/login_usecase.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);


  Future<void> login({required String email, required String password}) async {
    try {
      emit(state.copyWith(loginRequestState: RequestState.loading));

      await loginUseCase.callLogin(email: email, password: password);

      emit(state.copyWith(loginRequestState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(
        loginRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ===================== LOGIN WITH GOOGLE =====================
  Future<void> loginWithGoogle() async {
    try {
      emit(state.copyWith(loginWithGoogleRequestState: RequestState.loading));

      UserModel? user = await loginUseCase.callLoginWithGoogle();

      if (user != null) {
        emit(state.copyWith(loginWithGoogleRequestState: RequestState.success));
      } else {
        emit(state.copyWith(
          loginWithGoogleRequestState: RequestState.error,
          errorMessage: "Google sign-in failed",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loginWithGoogleRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
