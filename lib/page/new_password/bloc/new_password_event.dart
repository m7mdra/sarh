class NewPasswordEvent {}

class SubmitNewPassword extends NewPasswordEvent {
  final String newPassword;
  final String resetToken;
  final String phoneNumber;

  SubmitNewPassword(this.newPassword, this.resetToken, this.phoneNumber);
}
