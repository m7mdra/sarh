import 'package:Sarh/data/exceptions/session_expired_exception.dart';
import 'package:Sarh/data/exceptions/timeout_exception.dart';
import 'package:Sarh/data/exceptions/unable_to_connect_exception.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:Sarh/page/verify_account/bloc/timer/timer_bloc.dart';
import 'package:Sarh/page/verify_account/bloc/verification_bloc/verify_account_bloc_event.dart';
import 'package:Sarh/page/verify_account/bloc/verification_bloc/verify_account_bloc_state.dart';
import 'package:bloc/bloc.dart';

class VerifyAccountBloc extends Bloc<VerificationEvent, VerificationState> {
  final UserRepository userRepository;
  final Session session;
  final TimerBloc timerBloc;

  VerifyAccountBloc(this.userRepository, this.session, this.timerBloc);

  @override
  get initialState => IdleState();

  @override
  Stream<VerificationState> mapEventToState(VerificationEvent event) async* {
    if (event is VerifyAccount) {
      yield Loading();
      try {
        var response = await userRepository.verifyAccount(event.code);
        if (response.success) {
          await session.saveUser(
              response.token, response.user, response.company);

          yield Success();
        } else {
          yield InvalidCode();
        }
      } on SessionExpiredException {
        yield SessionExpired();
      } on UnableToConnectException {
        yield NetworkError();
      } on TimeoutException {
        yield Timeout();
      } catch (error) {
        yield Failed();
        print(error);
      }
    }
    if (event is ResentVerificationCode) {
      yield ResendLoading();
      try {
        var response = await userRepository.requestCode();
        if (response.success) {
          timerBloc.dispatch(Start());
          yield ResendRequested();
        } else {
          yield ResendFailed();
        }
      } on SessionExpiredException {
        yield SessionExpired();
      } on UnableToConnectException {
        yield NetworkError();
      } on TimeoutException {
        yield Timeout();
      } catch (error) {
        yield ResendFailed();
      }
    }
    if (event is LoadPhoneNumber) {
      yield PhoneNumberLoaded(session.user.phone);
    }
  }
}
