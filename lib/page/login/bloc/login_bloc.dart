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

import 'package:Sarh/data/exceptions/session_expired_exception.dart';
import 'package:Sarh/data/exceptions/timeout_exception.dart';
import 'package:Sarh/data/exceptions/unable_to_connect_exception.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'login_event_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final Session session;

  LoginBloc(this.userRepository, this.session);

  @override
  LoginState get initialState => IdleState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AttemptLogin) {
      yield LoadingState();
      try {
        var response = await userRepository.login(event.id, event.password);
        if (response.success) {
          await session.saveUser(
              response.token, response.user, response.company);
          if (response.user.isAccountVerified) {
            if (response.isCompany) {
              if (response.companyProfileCompleted) {
                yield SuccessState();
              } else {
                yield ProfileNotCompleted();
              }
            } else {
              yield SuccessState();
            }
          } else {
            yield AccountNotVerified();
          }
        } else {
          yield InvalidUsernameOrPassword();
        }
      } on SessionExpiredException {
        yield InvalidUsernameOrPassword();
      } on UnableToConnectException {
        yield NetworkError();
      } on TimeoutException {
        yield Timeout();
      } catch (error) {
        print("Error: $error");
        yield LoginError('Failed to login, try again');
      }
    }
  }
}
