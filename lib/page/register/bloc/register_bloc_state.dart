import 'package:Sarh/data/model/city.dart';

class RegisterState {}

class CitiesLoaded extends RegisterState {
  final List<City> cities;

  CitiesLoaded(this.cities);
}

class IdleState extends RegisterState {}
