
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Features/Authentication/domain/Use%20Cases/forgetPass_usecase.dart';
import 'package:movie_app/Features/Authentication/persentation/Screens/Forget%20Password%20Screen/Forget%20Password%20Cubit/states.dart';

class ForgetPassCubit extends Cubit<ForgetPassState>{
  ForgetPassCubit(this.useCase) : super(ForgetPassInitialState());
  static ForgetPassCubit get(context)=>BlocProvider.of<ForgetPassCubit>(context);
  ForgetPasswordUseCase useCase;

  Future<void> forgetPass(String email) async {
    try {
      emit(state.copyWith(forgetPassRequestState: RequestState.loading));
      await useCase.callForgetPass(email);
      emit(state.copyWith(forgetPassRequestState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(forgetPassRequestState: RequestState.error,errorMessage: e.toString()));
      rethrow;
    }
  }


}