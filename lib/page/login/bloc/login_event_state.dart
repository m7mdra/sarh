/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

class LoginEvent {}
class AttemptLogin extends LoginEvent {
  final String id;
  final String password;

  AttemptLogin(this.id, this.password);
}


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

