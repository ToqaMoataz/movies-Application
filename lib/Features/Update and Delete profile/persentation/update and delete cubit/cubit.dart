
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/Features/Update%20and%20Delete%20profile/domail/Edit%20Profile%20repo/update_profile_repo.dart';
import 'package:movie_app/Features/Update%20and%20Delete%20profile/domail/Use%20Cases/updateProfile_base_usecase.dart';
import 'package:movie_app/Features/Update%20and%20Delete%20profile/persentation/update%20and%20delete%20cubit/states.dart';

import '../../../../Core/Models/User/user_model.dart';

import '../../../HomeScreen/domain/Abstract repo/user_repo.dart';

@injectable
class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileUseCases profileUseCases;
  UpdateProfileCubit(this.profileUseCases) : super(UpdateProfileInitState());
  static UpdateProfileCubit get(context) => BlocProvider.of<UpdateProfileCubit>(context);

  void showImagesDialog(bool show) {
    emit(state.copyWith(showDialog: show));
  }

  void setSelectedImage(String imageName){
    emit(state.copyWith(selectedImage: imageName));
  }
  void getUserImage(UserModel user){
    emit(state.copyWith(selectedImage: user.image));
  }

  Future<void> updateUser(String name,String phoneNumber,String imageName)async{
    try {
      emit(state.copyWith(updateProfileRequestState: RequestState.loading));
      print("Stateee : ${state.updateProfileRequestState}");
      await profileUseCases.updateUserDataUC.call(name: name, phoneNumber: phoneNumber,image: imageName);
      emit(state.copyWith(updateProfileRequestState: RequestState.success));
      print("Stateee : ${state.updateProfileRequestState}");
    } catch (e) {
      emit(state.copyWith(
        updateProfileRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
      print("Stateee : ${state.updateProfileRequestState}, Error Message: ${state.errorMessage}");
    }
  }

  Future<void> deleteUser() async {
    try {
      emit(state.copyWith(deleteProfileRequestState: RequestState.loading));
      await profileUseCases.deleteUserUC.call();
      emit(state.copyWith(deleteProfileRequestState: RequestState.success));
    } catch (e) {
      emit(state.copyWith(
        deleteProfileRequestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }


}
