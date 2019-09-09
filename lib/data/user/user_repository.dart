import 'dart:io';

import 'package:Sarh/data/either.dart';
import 'package:Sarh/data/exceptions/timeout_exception.dart';
import 'package:Sarh/data/exceptions/unable_to_connect_exception.dart';
import 'package:Sarh/data/response_status.dart';
import 'package:dio/dio.dart';
import 'model/authentication_response_error.dart';
import 'model/authentication_response.dart';
import 'package:Sarh/data/exceptions/session_expired_exception.dart';

import 'model/resend_verification_response.dart';

class UserRepository {
  final Dio _client;

  UserRepository(this._client);

  Future<AuthenticationResponse> login(String username, String password) async {
    try {
      var response = await _client.post('account/login',
          data: {'username': username, 'password': password});
      print(response.data);
      return AuthenticationResponse.fromJson(response.data);
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

  Future<ResendVerificationCodeResponse> requestCode() async {
    try {
      var response = await _client.post('customer/verificationresend');
      return ResendVerificationCodeResponse.fromJson(response.data);
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
    }
  }

  Future<AuthenticationResponse> verifyAccount(String code) async {
    try {
      var response = await _client
          .post('customer/verificationcode', data: {'verificationCode': code});
      return AuthenticationResponse.fromJson(response.data);
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
      print(error);

      throw error;
    }
  }

  Future<Either<AuthenticationResponse, AuthenticationResponseError>> register(
      String fullName,
      String username,
      String phone,
      int accountType,
      int city,
      String password,
      String messagingToken) async {
    try {
      var response = await _client.post('customer/register', data: {
        'fullname': fullName,
        'username': username,
        'phone': phone,
        'account_type': accountType,
        'city': city,
        'password': password,
        'c_password': password,
        'firebaseToken': messagingToken
      });
      return Either.withSuccess(AuthenticationResponse.fromJson(response.data));
    } on DioError catch (error) {
      switch (error.type) {
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
          throw TimeoutException();
          break;
        case DioErrorType.RESPONSE:
          return Either.withError(
              AuthenticationResponseError.fromJson(error.response.data));
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

  Future<AuthenticationResponse> profile() async {
    try {
      var response = await _client.get('customer/profile');
      return AuthenticationResponse.fromJson(response.data);
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

  Future<ResponseStatus> uploadProfileImage(File file) async {
    try {
      FormData formData =
          FormData.from({'image': new UploadFileInfo(file, 'image')});
      var response = await _client.post('customer/uploadImage', data: formData);
      return ResponseStatus.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response.statusCode == HTTP_UNAUTHORIZED)
        throw SessionExpiredException();
      else
        throw error;
    } catch (error) {
      throw error;
    }
  }
}
