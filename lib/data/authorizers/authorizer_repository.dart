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

import 'dart:io';

import 'package:Sarh/data/authorizers/model/authorizers_response.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';
import 'package:Sarh/data/response_status.dart';
import 'package:dio/dio.dart';


class AuthorizersRepository {
  final Dio _client;

  AuthorizersRepository(this._client);

  Future<AuthorizerResponse> getAuthorizers() async {
    try {
      var response = await _client.get('company_authorizers');
      return AuthorizerResponse.fromJson(response.data);
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

  Future<ResponseStatus> deleteAuthorizer(int id) async {
    try {
      var response = await _client.delete(
        'company_authorizers/$id',
      );
      return ResponseStatus.fromJson(response.data);
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

  Future<ResponseStatus> addAuthorizer(
      String name, File logo, int accountId) async {
    try {
      var response = await _client.post('company_authorizers',
          data: FormData.from({
            'name': name,
            'logo': UploadFileInfo(logo, logo.path),
            'acccount_id': accountId
          }));
      return ResponseStatus.fromJson(response.data);
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

  Future<ResponseStatus> updateAuthorizer(
      String name, File logo, int accountId, int id) async {
    try {
      var response = await _client.put('company_authorizers/$id',
          data: FormData.from({
            'name': name,
            'logo': UploadFileInfo(logo, logo.path),
            'acccount_id': accountId
          }));
      return ResponseStatus.fromJson(response.data);
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
