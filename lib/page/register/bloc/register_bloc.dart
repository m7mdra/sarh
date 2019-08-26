import 'package:Sarh/data/country/city_repository.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/data/user/user_repository.dart';
import 'package:Sarh/page/register/bloc/register_bloc_event.dart';
import 'package:Sarh/page/register/bloc/register_bloc_state.dart';
import 'package:bloc/bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final Session session;
  final CountryRepository countryRepository;

  RegisterBloc(this.userRepository, this.session, this.countryRepository);

  @override
  RegisterState get initialState => IdleState();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is LoadCities) {
      var response = await countryRepository.getCities();
      if (response.success) yield CitiesLoaded(response.cities);
    }
  }
}
