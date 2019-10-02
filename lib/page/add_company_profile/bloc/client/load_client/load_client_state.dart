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
