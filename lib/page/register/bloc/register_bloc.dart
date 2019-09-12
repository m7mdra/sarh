import 'package:Sarh/data/country/city_repository.dart';
import 'package:Sarh/data/exceptions/timeout_exception.dart';
import 'package:Sarh/data/exceptions/unable_to_connect_exception.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:Sarh/page/account_type/account_type_page.dart';
import 'package:Sarh/page/register/bloc/register_bloc_event.dart';
import 'package:Sarh/page/register/bloc/register_bloc_state.dart';
import 'package:bloc/bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final Session session;
  final CountryRepository countryRepository;

  RegisterBloc(this.userRepository, this.session, this.countryRepository);

  @override
  RegisterState get initialState => Idle();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is LoadCities) {
      var response = await countryRepository.getCities();
      if (response.success) yield CitiesLoaded(response.cities);
    }
    if (event is Register) {
      yield Loading();
      try {
        var either = await userRepository.register(
            event.name,
            event.phoneNumber,
            event.accountType,
            event.city,
            event.password,
            event.messagingToken,
          event.email,
        );
        if (either.hasFirst) {
          var successResponse = either.first;
          if (successResponse.success) {
            await session.saveUser(successResponse.token, successResponse.user,
                successResponse.company);
            yield Success(successResponse.user.accountType == 1
                ? AccountType.personal
                : AccountType.service_provider);
          }
        } else {
          var errorResponse = either.second;
          yield RegisterError(errorResponse.errors);
        }
      } on TimeoutException {
        yield Timeout();
      } on UnableToConnectException {
        yield NetworkError();
      } catch (error) {
        yield Error();
      }
    }
  }
}
