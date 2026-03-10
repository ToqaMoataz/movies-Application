abstract class LoginStates {}

class LoginState extends LoginStates {
  final RequestState loginRequestState;
  final RequestState loginWithGoogleRequestState;
  final bool passVisible;
  final String? errorMessage;

  LoginState({
    this.loginRequestState = RequestState.init,
    this.loginWithGoogleRequestState = RequestState.init,
    this.errorMessage,
    this.passVisible=false
  });

  LoginState copyWith({
    RequestState? loginRequestState,
    RequestState? loginWithGoogleRequestState,
    String? errorMessage,
    bool? passVisible
  }) {
    return LoginState(
      loginRequestState: loginRequestState ?? this.loginRequestState,
      loginWithGoogleRequestState:
      loginWithGoogleRequestState ?? this.loginWithGoogleRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
      passVisible: passVisible ?? this.passVisible,
    );
  }
}

class LoginInitialState extends LoginState {}

enum RequestState { init, loading, error, success }

