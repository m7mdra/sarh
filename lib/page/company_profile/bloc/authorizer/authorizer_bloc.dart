import 'dart:collection';

import 'package:Sarh/data/authorizers/authorizer_repository.dart';
import 'package:Sarh/data/company/company_repository.dart';
import 'package:bloc/bloc.dart';

import 'bloc.dart';

class AuthorizersBloc extends Bloc<AuthorizerEvent, AuthorizerState> {
  final AuthorizersRepository _authorizersRepository;

  AuthorizersBloc(this._authorizersRepository);

  @override
  AuthorizerState get initialState => AuthorizerState();

  @override
  Stream<AuthorizerState> mapEventToState(AuthorizerEvent event) async* {
    if (event is LoadAuthroizers) {
      yield AuthorizerLoading();
      try {
        var response = await _authorizersRepository.getAuthorizers();
        if (response.success) {
          var list = response.data;
          if (list.isNotEmpty) {
            yield AuthorizersLoaded(UnmodifiableListView([]));
          } else {
            yield AuthorizersEmpty();
          }
        }
      } catch (error) {
        yield AuthorizersFailed();
      }
    }
  }
}
