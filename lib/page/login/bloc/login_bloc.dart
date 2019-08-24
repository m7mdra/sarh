import 'package:bloc/bloc.dart';
import 'login_event_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => IdleState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AttemptLogin) {
      yield LoadingState();
      await Future.delayed(Duration(seconds: 3));
      yield SuccessState();
    }
  }
}
