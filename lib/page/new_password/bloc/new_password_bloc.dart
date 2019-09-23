import 'package:Sarh/page/new_password/bloc/new_password_event.dart';
import 'package:Sarh/page/new_password/bloc/new_password_state.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/user/user_repository.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  final UserRepository _userRepository;

  NewPasswordBloc(this._userRepository);

  @override
  NewPasswordState get initialState => NewPasswordState();

  @override
  Stream<NewPasswordState> mapEventToState(NewPasswordEvent event) async* {
    if (event is SubmitNewPassword) {
      yield Loading();
      try {
        var response = await _userRepository.submitNewPassword(
            event.phoneNumber, event.resetToken, event.newPassword);
        if (response.success) {
          yield Success();
        } else {
          yield Failed();
        }
      } on TimeoutException {
        yield Timeout();
      } on UnableToConnectException {
        yield NetworkError();
      } catch (error) {
        yield Failed();
      }
    }
  }
}
