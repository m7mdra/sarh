import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:Sarh/page/splash/bloc/session_bloc_event.dart';
import 'package:Sarh/page/splash/bloc/session_bloc_state.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/exceptions/session_expired_exception.dart';
import 'package:Sarh/data/exceptions/timeout_exception.dart';
import 'package:Sarh/data/exceptions/unable_to_connect_exception.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final Session _session;
  final UserRepository _userRepository;

  SessionBloc(this._session, this._userRepository);

  @override
  SessionState get initialState => AuthenticationUninitialized();

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(error);
    print(stacktrace);
  }

  @override
  void onTransition(Transition<SessionEvent, SessionState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    if (state is Update) {
      var profile = await _userRepository.profile();
      if (profile.success) {
        _session.saveUser(profile.token, profile.user, profile.company);
        print(profile.toJson());
      }
    }
    await Future.delayed(Duration(seconds: 2));
    if (event is AppStarted) {
      if (_session.token != null && _session.token.isNotEmpty) {
        if (_session.user.isAccountVerified) {
          if (_session.isCompany) {
            if (_session.companyProfileCompleted) {
              yield UserAuthenticated();
            } else {
              yield ProfileNotCompleted();
            }
          } else {
            yield UserAuthenticated();
          }
        } else {
          try {
            var profile = await _userRepository.profile();
            if (profile.success) {
              if (profile.user.isAccountVerified) {
                await _session.saveUser(
                    profile.token, profile.user, profile.company);
                if (_session.isCompany) {
                  if (_session.companyProfileCompleted) {
                    yield UserAuthenticated();
                  } else {
                    yield ProfileNotCompleted();
                  }
                } else {
                  yield UserAuthenticated();
                }
              } else {
                yield AccountNotVerified();
              }
            } else {
              _clearAndNavigateToLogin();
            }
          } on UnableToConnectException {
            _clearAndNavigateToLogin();
          } on SessionExpiredException {
            _clearAndNavigateToLogin();
          } on TimeoutException {
            _clearAndNavigateToLogin();
          } catch (error) {
            print(error);
            _clearAndNavigateToLogin();
          }
        }
      } else {
        yield UserUnauthenticated();
      }
    }
  }

  Stream<SessionState> _clearAndNavigateToLogin() async* {
    _session.clear();
    yield UserUnauthenticated();
  }
}
