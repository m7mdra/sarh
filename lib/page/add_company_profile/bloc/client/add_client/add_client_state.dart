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

class AddClientState {}

class LoadingAdd extends AddClientState {}

class AddNetworkError extends AddClientState {}

class AddSessionExpired extends AddClientState {}

class AddTimeout extends AddClientState {}

class NewClientAdded extends AddClientState {}

class AddIdle extends AddClientState {}

class AddError extends AddClientState {}
