class ResetVerificationEvent {}

class VerifyAccount extends ResetVerificationEvent {
  final String code;

  VerifyAccount(this.code);
}

class ResentVerificationCode extends ResetVerificationEvent {
  final String phoneNumber;

  ResentVerificationCode(this.phoneNumber);
}

