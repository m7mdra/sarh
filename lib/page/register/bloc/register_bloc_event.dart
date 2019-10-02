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

class RegisterEvent {}

class LoadCities extends RegisterEvent {}

class Register extends RegisterEvent {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final int city;
  final int accountType;
  final String messagingToken;

  Register(
      {this.name,
      this.email,
      this.phoneNumber,
      this.password,
      this.city,
      this.messagingToken,
      this.accountType});


}
