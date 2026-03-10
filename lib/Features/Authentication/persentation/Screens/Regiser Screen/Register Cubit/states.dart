import '../../../../../../Core/assets/App Images/app_images.dart';

abstract class RegisterStates {}

class RegisterState extends RegisterStates {
  final RequestState registerRequestState;
  final String? errorMessage;

  bool passwordVisible;
  bool rePasswordVisible;

   String avatar;
  int currentIndex;
  String selectedImage;

  final List<String> profileImages;

  RegisterState({
    this.registerRequestState = RequestState.init,
    this.errorMessage,
    this.passwordVisible = false,
    this.rePasswordVisible = false,
    this.currentIndex = 0,
    this.avatar = "Avatar",
    List<String>? profileImages,
    String? selectedImage,
  })  : profileImages = profileImages ?? AppImages.getUserImages(),
        selectedImage = selectedImage ?? (profileImages ?? AppImages.getUserImages())[0];

  RegisterState copyWith({
    RequestState? registerRequestState,
    String? errorMessage,
    bool? passwordVisible,
    bool? rePasswordVisible,
    String? avatar,
    int? currentIndex,
    String? selectedImage,
    List<String>? profileImages,
  }) {
    final updatedProfileImages = profileImages ?? this.profileImages;

    return RegisterState(
      registerRequestState: registerRequestState ?? this.registerRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      rePasswordVisible: rePasswordVisible ?? this.rePasswordVisible,
      avatar: avatar ?? this.avatar,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedImage: selectedImage ?? this.selectedImage,
      profileImages: updatedProfileImages,
    );
  }
}

class RegisterInitialState extends RegisterState {
  RegisterInitialState()
      : super(
    profileImages: AppImages.getUserImages(),
    selectedImage: AppImages.getUserImages()[0],
  );
}

enum RequestState { init, loading, error, success }
