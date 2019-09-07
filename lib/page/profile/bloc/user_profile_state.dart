import 'package:Sarh/data/model/user.dart';

class UserProfileState {}

class ProfileLoaded extends UserProfileState {
  final User user;

  ProfileLoaded(this.user);
}

class ProfileLoadedFromNetwork extends UserProfileState {
  final User user;

  ProfileLoadedFromNetwork(this.user);
}
