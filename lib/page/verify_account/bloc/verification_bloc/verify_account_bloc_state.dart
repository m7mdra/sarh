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

class VerificationState {}

class Loading extends VerificationState {}

class ResendLoading extends VerificationState {}

class NetworkError extends VerificationState {}

class Success extends VerificationState {}

class InvalidCode extends VerificationState {}

class IdleState extends VerificationState {}

class Failed extends VerificationState {}

class ResendRequested extends VerificationState {}

class ResendFailed extends VerificationState {}

class NavigateToCompleteProfilePage extends VerificationState {}

class NavigateToInterestPickerPage extends VerificationState {}

class PhoneNumberLoaded extends VerificationState {
  final String phoneNumber;

  PhoneNumberLoaded(this.phoneNumber);
}

class SessionExpired extends VerificationState {}

class Timeout extends VerificationState {}
