import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:Sarh/page/splash/bloc/session_bloc_event.dart';
import 'package:Sarh/page/splash/bloc/session_bloc_state.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/exceptions/session_expired_exception.dart';
import 'package:Sarh/data/exceptions/timeout_exception.dart';
import 'package:Sarh/data/exceptions/unable_to_connect_exception.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final Session session;
  final UserRepository userRepository;

  SessionBloc(this.session, this.userRepository);

  @override
  SessionState get initialState => AuthenticationUninitialized();

  @override
  void onError(Object error, StackTrace stacktrace) {
    // TODO: implement onError
    super.onError(error, stacktrace);
    print(error);
    print(stacktrace);
  }

  @override
  Stream<SessionState> mapEventToState(SessionEvent event) async* {
    await Future.delayed(Duration(seconds: 2));
    if (event is AppStarted) {
      print('session token found? ${session.token}');
      if (session.token != null && session.token.isNotEmpty) {
        if (session.user.isAccountVerified) {
          print('session found and account is verified');
          yield UserAuthenticated();
        } else {
          print('session found and account is not verified');
          try {
            print(
                'trying to check if user verified his account in another way');
            var profile = await userRepository.profile();
            if (profile.success) {
              if (profile.user.isAccountVerified) {
                session.saveUser(profile.token, profile.user, profile.company);
                yield UserAuthenticated();
              } else {
                yield AccountNotVerified();
              }
            } else {
              clearAndNavigateToLogin();
            }
          } on UnableToConnectException {
            clearAndNavigateToLogin();
          } on SessionExpiredException {
            clearAndNavigateToLogin();
          } on TimeoutException {
            clearAndNavigateToLogin();
          } catch (error) {
            print(error);
            clearAndNavigateToLogin();
          }
        }
      } else {
        print('no account found, going to login');
        yield UserUnauthenticated();
      }
    }
  }

  Stream<SessionState> clearAndNavigateToLogin() async* {
    session.clear();
    yield UserUnauthenticated();
  }
}
