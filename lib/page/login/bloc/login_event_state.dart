class LoginEvent {}

class LoginState {}

class IdleState extends LoginState {}

class LoadingState extends LoginState {}

class NetworkError extends LoginState {}

class InvalidUsernameOrPassword extends LoginState {}

class SuccessState extends LoginState {}

class AttemptLogin extends LoginEvent {
  final String id;
  final String password;

  AttemptLogin(this.id, this.password);
}
