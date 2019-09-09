import 'package:Sarh/data/model/client.dart';

class LoadClientState {}

class LoadingClients extends LoadClientState {}

class LoadNetworkError extends LoadClientState {}

class LoadSessionExpired extends LoadClientState {}

class LoadTimeout extends LoadClientState {}

class ClientsLoaded extends LoadClientState {
  final List<Client> clients;

  ClientsLoaded(this.clients);
}

class LoadIdle extends LoadClientState {}

class LoadError extends LoadClientState {}

class LoadEmpty extends LoadClientState {}
