import 'package:Sarh/data/exceptions/exceptions.dart';
import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:dio/dio.dart';

class AccountResetBloc extends Bloc<AccountResetEvent, AccountResetState> {
  final UserRepository userRepository;

  AccountResetBloc(this.userRepository);

  @override
  AccountResetState get initialState => AccountResetState();

  @override
  void onTransition(
      Transition<AccountResetEvent, AccountResetState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<AccountResetState> mapEventToState(AccountResetEvent event) async* {
    if (event is ResetAccount) {
      yield Loading();
      try {
        var responseStatus =
            await userRepository.requestResetLink(event.phoneNumber);
        if (responseStatus.success) {
          yield RequestSuccess(event.phoneNumber);
        } else {
          yield Error();
        }
      } on DioError catch (error) {
        switch (error.type) {
          case DioErrorType.CONNECT_TIMEOUT:
          case DioErrorType.SEND_TIMEOUT:
          case DioErrorType.RECEIVE_TIMEOUT:
            yield Timeout();
            break;
          case DioErrorType.RESPONSE:
            if (error.response.statusCode == 404)
              yield AccountNotFound();
            else if (error.response.statusCode == 422)
              yield InvalidPhoneNumber();
            else
              yield Error();
            break;
          case DioErrorType.CANCEL:
            yield Error();
            break;
          case DioErrorType.DEFAULT:
            yield NetworkError();
            break;
          default:
            yield Error();
        }
      }
    }
  }
}
