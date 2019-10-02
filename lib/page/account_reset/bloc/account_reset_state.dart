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

class AccountResetState {}

class Loading extends AccountResetState {}

class RequestSuccess extends AccountResetState {
  final String phoneNumber;

  RequestSuccess(this.phoneNumber);
}

class AccountNotFound extends AccountResetState {}

class InvalidPhoneNumber extends AccountResetState {}

class NetworkError extends AccountResetState {}

class Error extends AccountResetState {}

class Timeout extends AccountResetState{}
