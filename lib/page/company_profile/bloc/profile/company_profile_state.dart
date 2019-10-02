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

import 'package:Sarh/data/model/company.dart';
import 'package:Sarh/data/model/user.dart';

class CompanyProfileState {}

class ProfileLoaded extends CompanyProfileState {
  final User user;
  final Company company;

  ProfileLoaded(this.user, this.company);

  @override
  String toString() {
    return 'ProfileLoaded{user: ${user.toJson()}, company: ${company.toJson()}';
  }
}

class ProfileLoadedFromNetwork extends CompanyProfileState {
  final User user;

  ProfileLoadedFromNetwork(this.user);
}
