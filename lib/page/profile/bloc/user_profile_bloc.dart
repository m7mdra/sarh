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

import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserRepository userRepository;

  UserProfileBloc(this.userRepository);
  Session _session;

  SharedPreferences sharedPreferences;

  @override
  UserProfileState get initialState => UserProfileState();

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    sharedPreferences = await SharedPreferences.getInstance();
    _session = Session(sharedPreferences);
    if(event is Logout){
//      yield LogoutLoading();
      try {
        var logoutResponse =
        await userRepository.logout();
        if (logoutResponse.success) {
          print("BEFORE");
            yield LogoutSuccess();
          print("AFTER");
          }
        else {
          yield LogoutFailed();
        }
      } catch (error) {
        print(error);
      }
    }
    else{
      yield ProfileLoaded(_session.user);
    }
  }
}
