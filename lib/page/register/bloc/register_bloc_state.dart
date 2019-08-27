import 'package:Sarh/data/model/city.dart';
import 'package:Sarh/page/account_type/account_type_page.dart';

class RegisterState {}

class CitiesLoaded extends RegisterState {
  final List<City> cities;

  CitiesLoaded(this.cities);
}

class Idle extends RegisterState {}

class Loading extends RegisterState {}

class Error extends RegisterState {}

class RegisterError extends RegisterState {
  final String error;

  RegisterError(this.error);
}

class NetworkError extends RegisterState {}

class Timeout extends RegisterState {}

class Success extends RegisterState {
  final AccountType accountType;

  Success(this.accountType);
}
