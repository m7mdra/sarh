class ResetVerificationState {}

class Loading extends ResetVerificationState {}

class ResendLoading extends ResetVerificationState {}

class NetworkError extends ResetVerificationState {}

class Success extends ResetVerificationState {
  final String resetToken;

  Success(this.resetToken);

}

class InvalidCode extends ResetVerificationState {}

class IdleState extends ResetVerificationState {}

class Failed extends ResetVerificationState {}

class ResendRequested extends ResetVerificationState {}

class ResendFailed extends ResetVerificationState {}

