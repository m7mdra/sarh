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
