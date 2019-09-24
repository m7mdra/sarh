import 'package:Sarh/data/exceptions/session_expired_exception.dart';
import 'package:Sarh/data/exceptions/timeout_exception.dart';
import 'package:Sarh/data/exceptions/unable_to_connect_exception.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:Sarh/page/account_reset_verification/bloc/verify_reset_account_bloc_event.dart';
import 'package:Sarh/page/account_reset_verification/bloc/verify_reset_account_bloc_state.dart';
import 'package:Sarh/page/verify_account/bloc/timer/timer_bloc.dart';
import 'package:bloc/bloc.dart';

class VerifyResetAccountBloc extends Bloc<ResetVerificationEvent, ResetVerificationState> {
  final UserRepository userRepository;
  final TimerBloc timerBloc;

  VerifyResetAccountBloc(this.userRepository, this.timerBloc);

  @override
  get initialState => IdleState();


  @override
  Stream<ResetVerificationState> mapEventToState(ResetVerificationEvent event) async* {
    if (event is VerifyAccount) {
      yield Loading();
      try {
        var response = await userRepository.verifyResetCode(event.code);
        if (response.success) {
          yield Success(response.data.token);
        } else {
          yield InvalidCode();
        }
      }catch(error){
        yield Failed();
      }
    }

    if (event is ResentVerificationCode) {
      yield ResendLoading();
      try {
        var response = await userRepository.requestResetCode(event.phoneNumber);
        if (response.success) {
          timerBloc.dispatch(Start());
          yield ResendRequested();
        } else {
          yield ResendFailed();
        }
      }  catch (error) {
        yield ResendFailed();
      }
    }

  }
}
