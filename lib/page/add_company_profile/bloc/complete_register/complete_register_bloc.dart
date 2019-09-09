import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';

import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/company/company_repository.dart';

class CompleteRegisterBloc
    extends Bloc<CompleteRegisterEvent, CompleteRegisterState> {
  final CompanyRepository _companyRepository;
  final UserRepository _userRepository;
  final Session _session;

  CompleteRegisterBloc(
      this._companyRepository, this._userRepository, this._session);

  @override
  CompleteRegisterState get initialState => RegisterIdle();

  @override
  void onTransition(
      Transition<CompleteRegisterEvent, CompleteRegisterState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<CompleteRegisterState> mapEventToState(
      CompleteRegisterEvent event) async* {
    if (event is CompleteRegister) {
      yield RegisterLoading();
      try {
        var response = await _companyRepository
            .completeRegister(event.completeRegistrationModel);
        if (response.success) {
          var user = await _userRepository.profile();
          _session.saveUser(user.token, user.user, user.company);
          yield RegisterSuccess();
        } else {
          yield RegisterFailed();
        }
      } on SessionExpiredException {
        yield RegisterSessionExpired();
      } on TimeoutException {
        yield RegisterTimeout();
      } on UnableToConnectException {
        yield RegisterNetworkError();
      } catch (error) {
        yield RegisterFailed();
        print(error);
      }
    }
  }
}
