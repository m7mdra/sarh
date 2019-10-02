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

class CompanyProfileBloc
    extends Bloc<CompanyProfileEvent, CompanyProfileState> {
  final Session _session;

  CompanyProfileBloc(this._session);

  @override
  CompanyProfileState get initialState =>
      ProfileLoaded(_session.user, _session.company);

  @override
  Stream<CompanyProfileState> mapEventToState(
      CompanyProfileEvent event) async* {
    yield ProfileLoaded(_session.user, _session.company);
  }
}
