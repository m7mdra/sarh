import 'dart:async';
import 'dart:core' as prefix0;
import 'dart:core';

import 'package:Sarh/data/chat/model/chat_responce.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/model/chat_responses/chat.dart';
import 'package:dio/dio.dart';

class ChatRepository{
  final Dio _client;

  ChatRepository(this._client);

  Future<ChatResponse> getChats() async {
    try {
      var response = await _client.get('chat-with');
      print(response);
      return ChatResponse.fromJson(response.data);
    } on DioError catch (error) {
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
          throw TimeoutException();
          break;
        case DioErrorType.RESPONSE:
          if (error.response.statusCode == HTTP_UNAUTHORIZED)
            throw SessionExpiredException();
          else
            throw error;
          break;
        case DioErrorType.CANCEL:
          throw error;
          break;
        case DioErrorType.DEFAULT:
          throw UnableToConnectException();
          break;
        default:
          throw error;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<MessagesResponse> getMessagesWith(var token,var userId) async {
    print('getMessagesWith');
    try {
      var response = await _client.get('messages',queryParameters: {'token' : token,'user_id':userId});
      prefix0.print('RESPONCSE');
      print(response);
      return MessagesResponse.fromJson(response.data);
    } on DioError catch (error) {
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
          throw TimeoutException();
          break;
        case DioErrorType.RESPONSE:
          if (error.response.statusCode == HTTP_UNAUTHORIZED)
            throw SessionExpiredException();
          else
            throw error;
          break;
        case DioErrorType.CANCEL:
          throw error;
          break;
        case DioErrorType.DEFAULT:
          throw UnableToConnectException();
          break;
        default:
          throw error;
      }
    } catch (error) {
      throw error;
    }
  }


}