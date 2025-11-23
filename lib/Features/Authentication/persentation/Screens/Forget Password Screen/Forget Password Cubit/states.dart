abstract class ForgetPassStates {}

class ForgetPassState extends ForgetPassStates {
  final RequestState forgetPassRequestState;
  final String? errorMessage;

  ForgetPassState({
    this.forgetPassRequestState = RequestState.init,
    this.errorMessage,
  });

  ForgetPassState copyWith({
    RequestState? forgetPassRequestState,
    String? errorMessage,
  }) {
    return ForgetPassState(
      forgetPassRequestState: forgetPassRequestState ?? this.forgetPassRequestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ForgetPassInitialState extends ForgetPassState {}

enum RequestState { init, loading, error, success }
