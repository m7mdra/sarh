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

class CompleteRegisterState {}

class RegisterLoading extends CompleteRegisterState {}

class RegisterNetworkError extends CompleteRegisterState {}

class RegisterTimeout extends CompleteRegisterState {}

class RegisterSuccess extends CompleteRegisterState {}

class RegisterSessionExpired extends CompleteRegisterState {}

class RegisterFailed extends CompleteRegisterState {}

class RegisterIdle extends CompleteRegisterState {}
