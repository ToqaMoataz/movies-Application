
abstract class UpdateProfileStates {}

class UpdateProfileState extends UpdateProfileStates {
  final RequestState updateProfileRequestState;
  final RequestState deleteProfileRequestState;
  final RequestState showImagesDialogRequestState;
  final bool showDialog;
  final String selectedImage;
  final String? errorMessage;

  UpdateProfileState({
    this.updateProfileRequestState = RequestState.init,
    this.deleteProfileRequestState = RequestState.init,
    this.showImagesDialogRequestState = RequestState.init,
    this.showDialog = false,
    this.selectedImage = "",
    this.errorMessage,
  });

  UpdateProfileState copyWith({
    RequestState? updateProfileRequestState,
    RequestState? deleteProfileRequestState,
    RequestState? showImagesDialogRequestState,
    bool? showDialog,
    String? selectedImage, // ✅ added here
    String? errorMessage,
  }) {
    return UpdateProfileState(
      updateProfileRequestState:
      updateProfileRequestState ?? this.updateProfileRequestState,
      deleteProfileRequestState:
      deleteProfileRequestState ?? this.deleteProfileRequestState,
      showImagesDialogRequestState:
      showImagesDialogRequestState ?? this.showImagesDialogRequestState,
      showDialog: showDialog ?? this.showDialog,
      selectedImage: selectedImage ?? this.selectedImage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class UpdateProfileInitState extends UpdateProfileState {}

enum RequestState { init, loading, success, error }
