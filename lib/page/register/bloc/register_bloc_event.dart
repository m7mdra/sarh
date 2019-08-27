class RegisterEvent {}

class LoadCities extends RegisterEvent {}

class Register extends RegisterEvent {
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final String password;
  final int city;
  final int accountType;
  final String messagingToken;

  Register(
      {this.name,
      this.username,
      this.email,
      this.phoneNumber,
      this.password,
      this.city,
      this.messagingToken,
      this.accountType});

  @override
  String toString() {
    return 'Register{name: $name, email: $email, phoneNumber: $phoneNumber, password: $password, city: $city, accountType: $accountType, messagingToken: $messagingToken}';
  }
}
