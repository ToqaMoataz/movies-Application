import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../Core/Models/user_model.dart';

import '../../../../domain/Use Cases/register_usecase.dart';
import 'states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase useCase;

  RegisterCubit(this.useCase) : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of<RegisterCubit>(context);

  Future<void> register({required UserModel user, required String password}) async {
    try {
      emit(state.copyWith(registerRequestState: RequestState.loading));

      await useCase.callRegister(user: user, password: password);

      emit(state.copyWith(registerRequestState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(
        registerRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void setUserImage(int index){

    emit(state.copyWith(currentIndex: index,selectedImage: state.profileImages[index]));
  }

  void editUserName(String name){
    emit(state.copyWith(avatar: name));
  }

  void toggleVisibility(){
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  void toggleReVisibility(){
    emit(state.copyWith(rePasswordVisible: !state.rePasswordVisible));

  }
}
