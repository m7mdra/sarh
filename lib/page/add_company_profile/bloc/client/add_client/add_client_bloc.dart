import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/session.dart';
import 'package:Sarh/page/add_company_profile/bloc/client/add_client/add_client_state.dart';
import 'package:Sarh/page/add_company_profile/bloc/client/load_client/load_client_bloc.dart';
import 'package:Sarh/page/add_company_profile/bloc/client/load_client/load_client_event.dart';
import 'package:Sarh/page/add_company_profile/client_model.dart';

import 'add_client_event.dart';
import 'package:bloc/bloc.dart';
import 'package:Sarh/data/company/company_repository.dart';

class AddClientBloc extends Bloc<AddClientEvent, AddClientState> {
  final CompanyRepository _companyRepository;
  final Session _session;
  final LoadClientBloc _loadClientBloc;
  FeaturedClient _lastClient;

  AddClientBloc(this._companyRepository, this._session, this._loadClientBloc);

  @override
  AddClientState get initialState => AddIdle();

  @override
  Stream<AddClientState> mapEventToState(AddClientEvent event) async* {
    if (event is AddNewClient) {
      yield* _add(event.client);
    }
    if (event is RetryAdd) {
      yield* _add(_lastClient);
    }
  }

  Stream<AddClientState> _add(FeaturedClient client) async* {
    yield LoadingAdd();
    try {
      var response = await _companyRepository.addClient(
          clientName: client.name,
          accountId: _session.user.id,
          websiteUrl: client.website,
          logo: client.logo);
      _lastClient = client;
      if (response.success) {
        _loadClientBloc.dispatch(LoadClients());
        yield NewClientAdded();
      } else {
        yield AddError();
      }
    } on SessionExpiredException {
      yield AddSessionExpired();
    } on UnableToConnectException {
      yield AddNetworkError();
    } on TimeoutException {
      yield AddTimeout();
    } catch (error) {
      yield AddError();
    }
  }
}
