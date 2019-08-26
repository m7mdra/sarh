class VerificationEvent {}

class VerifyAccount extends VerificationEvent {
  final String code;

  VerifyAccount(this.code);
}

class ResentVerificationCode extends VerificationEvent {}

class LoadPhoneNumber extends VerificationEvent {}
