class LoginEvent {}

class LoginState {}

class IdleState extends LoginState {}

class LoadingState extends LoginState {}

class NetworkError extends LoginState {}

class Timeout extends LoginState {}


class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}

class AccountNotVerified extends LoginState {}
class ProfileNotCompleted extends LoginState {}

class InvalidUsernameOrPassword extends LoginState {}


class SuccessState extends LoginState {}

class AttemptLogin extends LoginEvent {
  final String id;
  final String password;

  AttemptLogin(this.id, this.password);
}
