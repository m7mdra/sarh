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
import 'dart:math';

import 'package:Sarh/data/chat/chat_repository.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/model/chat_responses/messages.dart';
import 'package:Sarh/data/session.dart';
import 'package:bloc/bloc.dart';
import 'bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CompanyMessagesBloc extends Bloc<CompanyMessagesEvent, CompanyMessagesState> {

  final ChatRepository _chatRepository;
  Session session;

  CompanyMessagesBloc(this._chatRepository,{this.session});

  @override
  // TODO: implement initialState
  CompanyMessagesState get initialState => OnLoading();

  @override
  Stream<CompanyMessagesState> mapEventToState(
      CompanyMessagesEvent event) async* {

    if (event is LoadCompanyMessages) {
      prefix0.print('TOKEN');
      yield OnLoading();
      try {
        var _messagesResponse =
        await _chatRepository.getMessagesWith(event.userId);
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
    else if(event is MessageAddToList){
      yield MessageAddedToList(event.message);
    }
    else if (event is AddNewMessage) {
      try {
        var _addMessageResponse =
        await _chatRepository.addNewMessage(event.message);
        prefix0.print('RESPONSE');
        print(_addMessageResponse);
        if (_addMessageResponse['success']) {
          prefix0.print('MESSAGES');
          yield CompanyMessagesState();
//          yield NewMessageAdded(Message.fromJson(_addMessageResponse['data']));
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
