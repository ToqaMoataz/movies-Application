abstract class LoginStates {}

class LoginState extends LoginStates {
  final RequestState loginRequestState;
  final RequestState loginWithGoogleRequestState;
  final String? errorMessage;

  LoginState({
    this.loginRequestState = RequestState.init,
    this.loginWithGoogleRequestState = RequestState.init,
    this.errorMessage,
  });

  LoginState copyWith({
    RequestState? loginRequestState,
    RequestState? loginWithGoogleRequestState,
    String? errorMessage,
  }) {
    return LoginState(
      loginRequestState: loginRequestState ?? this.loginRequestState,
      loginWithGoogleRequestState:
      loginWithGoogleRequestState ?? this.loginWithGoogleRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class LoginInitialState extends LoginState {}

enum RequestState { init, loading, error, success }

