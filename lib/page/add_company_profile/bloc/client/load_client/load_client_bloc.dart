import 'package:Sarh/data/company/company_repository.dart';
import 'package:bloc/bloc.dart';
import 'load_client_state.dart';
import 'load_client_event.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';

class LoadClientBloc extends Bloc<LoadClientEvent, LoadClientState> {
  final CompanyRepository _companyRepository;

  LoadClientBloc(this._companyRepository);

  @override
  // TODO: implement initialState
  LoadClientState get initialState => LoadIdle();

  @override
  Stream<LoadClientState> mapEventToState(LoadClientEvent event) async* {
    if (event is LoadClients || event is RetryLoad) {
      yield LoadingClients();
      try {
        var response = await _companyRepository.getCompanyClients();
        if (response.success) {
          var clients = response.clients;
          if (clients.isEmpty) {
            yield LoadEmpty();
          } else {
            yield ClientsLoaded(clients);
          }
        } else {
          yield LoadError();
        }
      } on SessionExpiredException {
        yield LoadSessionExpired();
      } on UnableToConnectException {
        yield LoadNetworkError();
      } on TimeoutException {
        yield LoadTimeout();
      } catch (error) {
        yield LoadError();
        print(error);
      }
    }
  }
}
