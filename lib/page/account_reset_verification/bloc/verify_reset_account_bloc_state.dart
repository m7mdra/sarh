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

