import '../../../client_model.dart';

class AddClientEvent {}

class AddNewClient extends AddClientEvent {
  final FeaturedClient client;

  AddNewClient(this.client);
}

class RetryAdd extends AddClientEvent {}
