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

import 'dart:collection';

import 'package:Sarh/data/model/authorizer.dart';

class AuthorizerState {}

class AuthorizerLoading extends AuthorizerState {}

class AuthorizersEmpty extends AuthorizerState {}

class AuthorizersLoaded extends AuthorizerState {
  final UnmodifiableListView<Authorizer> authorizers;

  AuthorizersLoaded(this.authorizers);
}

class AuthorizersFailed extends AuthorizerState {}
