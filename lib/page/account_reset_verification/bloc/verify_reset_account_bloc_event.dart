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

class ResetVerificationEvent {}

class VerifyAccount extends ResetVerificationEvent {
  final String code;

  VerifyAccount(this.code);
}

class ResentVerificationCode extends ResetVerificationEvent {
  final String phoneNumber;

  ResentVerificationCode(this.phoneNumber);
}

