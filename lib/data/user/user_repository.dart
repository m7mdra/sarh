import 'dart:io';

import 'package:Sarh/data/either.dart';
import 'package:dio/dio.dart';
import 'model/authentication_response_error.dart';
import 'model/authentication_response.dart';
import 'package:Sarh/data/exceptions/session_expired_exception.dart';

class UserRepository {
  final Dio _client;

  UserRepository(this._client);

  Future<Either<AuthenticationResponse, AuthenticationResponseError>> login(
      String username, String password) async {
    try {
      var response = await _client.post('account/login',
          data: {'username': username, 'password': password});
      return Either.withError(AuthenticationResponse.fromJson(response.data));
    } on DioError catch (error) {
      return Either.withSuccess(
          AuthenticationResponseError.fromJson(error.response.data));
    } catch (error) {
      throw error;
    }
  }

  Future<AuthenticationResponse> verifyAccount(String code) async {
    try {
      var response = await _client
          .post('customer/verificationcode', data: {'verificationCode': code});
      return AuthenticationResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response.statusCode == HTTP_UNAUTHORIZED)
        throw SessionExpired();
      else
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
      return Either.withError(AuthenticationResponse.fromJson(response.data));
    } on DioError catch (error) {
      return Either.withSuccess(
          AuthenticationResponseError.fromJson(error.response.data));
    } catch (error) {
      throw error;
    }
  }

  Future<AuthenticationResponse> profile() async {
    try {
      var response = await _client.post('customer/profile');
      return AuthenticationResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response.statusCode == HTTP_UNAUTHORIZED)
        throw SessionExpired();
      else
        throw error;
    } catch (error) {
      throw error;
    }
  }

  Future<AuthenticationResponse> uploadProfileImage(File file) async {
    try {
      FormData formData =
          FormData.from({'image': new UploadFileInfo(file, 'image')});
      var response = await _client.post('customer/uploadImage', data: formData);
      return AuthenticationResponse.fromJson(response.data);
    } on DioError catch (error) {
      if (error.response.statusCode == HTTP_UNAUTHORIZED)
        throw SessionExpired();
      else
        throw error;
    } catch (error) {
      throw error;
    }
  }
}
