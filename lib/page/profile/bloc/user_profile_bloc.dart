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
import 'package:bloc/bloc.dart';
import 'bloc.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final Session _session;

  UserProfileBloc(this._session);

  @override
  UserProfileState get initialState => ProfileLoaded(_session.user);

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    yield ProfileLoaded(_session.user);
  }
}
