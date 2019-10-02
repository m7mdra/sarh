/*
 * Copyright (c) 2019.
 *           ______             _
 *          |____  |           | |
 *  _ __ ___    / / __ ___   __| |_ __ __ _
 * | '_ ` _ \  / / '_ ` _ \ / _` | '__/ _` |
 * | | | | | |/ /| | | | | | (_| | | | (_| |
 * |_| |_| |_/_/ |_| |_| |_|\__,_|_|  \__,_|
 *
 *
 *
 *
 */

import 'package:Sarh/data/client/client_repository.dart';
import 'package:Sarh/data/company/company_repository.dart';
import 'package:bloc/bloc.dart';
import 'load_client_state.dart';
import 'load_client_event.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';

class LoadClientBloc extends Bloc<LoadClientEvent, LoadClientState> {
  final ClientRepository _clientRepository;

  LoadClientBloc(this._clientRepository);

  @override
  // TODO: implement initialState
  LoadClientState get initialState => LoadIdle();

  @override
  Stream<LoadClientState> mapEventToState(LoadClientEvent event) async* {
    if (event is LoadClients || event is RetryLoad) {
      yield LoadingClients();
      try {
        var response = await _clientRepository.getCompanyClients();
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
