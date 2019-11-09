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

import 'dart:core' as prefix0;
import 'dart:core';

import 'package:Sarh/data/chat/chat_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/session.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CompanyMessagesBloc extends Bloc<CompanyMessagesEvent, CompanyMessagesState> {

  final ChatRepository _chatRepository;
  Session session;
  SharedPreferences _preferences ;

  CompanyMessagesBloc(this._chatRepository,{this.session});

  @override
  // TODO: implement initialState
  CompanyMessagesState get initialState => CompanyMessagesState();

  @override
  Stream<CompanyMessagesState> mapEventToState(
      CompanyMessagesEvent event) async* {
    _preferences = await SharedPreferences.getInstance();

    var token = _preferences.get('token');
    prefix0.print("DATA USER");
    print(token);
    var userId = _preferences.get('user_id');
    prefix0.print("DATA USER");
    print(token);
    print(userId);


    if (event is LoadCompanyMessages) {
      prefix0.print('TOKEN');
//      print(session.token);
      yield OnLoading();
      try {
        var _messagesResponse =
        await _chatRepository.getMessagesWith(token, userId);
        prefix0.print('SUCCESS');
        print(_messagesResponse.success);
        if (_messagesResponse.success) {
          prefix0.print('MESSAGES');
          print(_messagesResponse.data.messages.length);
          prefix0.print('QUOTATIONS');
          print(_messagesResponse.data.quotations.length);

          yield OnLoaded(_messagesResponse.data.messages,_messagesResponse.data.quotations);

        } else {
          yield CompanyMessagesError();
        }
      } on UnableToConnectException {
        yield CompanyMessagesNetworkError();
      } on TimeoutException {
        yield CompanyMessagesNetworkError();
      } on SessionExpiredException {
        yield CompanyMessagesSessionExpired();
      } catch (error) {
        yield CompanyMessagesError();
      }
    }
  }
}
