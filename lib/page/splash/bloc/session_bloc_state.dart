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

class SessionState {}

class AccountNotVerified extends SessionState {}

class UserAuthenticated extends SessionState {}

class UserUnauthenticated extends SessionState {}

class AuthenticationUninitialized extends SessionState {}

class ProfileNotCompleted extends SessionState {}

class Idle extends SessionState {}
