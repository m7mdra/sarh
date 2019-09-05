import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/user/user_repository.dart';

import 'bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/company/company_repository.dart';

class CompleteRegisterBloc
    extends Bloc<CompleteRegisterEvent, CompleteRegisterState> {
  final CompanyRepository _companyRepository;

  CompleteRegisterBloc(this._companyRepository);

  @override
  CompleteRegisterState get initialState => RegisterIdle();

  @override
  Stream<CompleteRegisterState> mapEventToState(
      CompleteRegisterEvent event) async* {
    if (event is CompleteRegister) {
      yield RegisterLoading();
      try {
        var response = await _companyRepository
            .completeRegister(event.completeRegistrationModel);
        if (response.success) {

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
      }
    }
  }
}
