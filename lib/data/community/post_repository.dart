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

import 'package:Sarh/data/community/model/post_response.dart';
import 'package:Sarh/data/response_status.dart';
import 'package:dio/dio.dart';
import 'package:Sarh/data/exceptions/exceptions.dart';

import 'model/add_post_response.dart';
import 'model/post_like_response.dart';

class PostRepository {
  final Dio _client;

  PostRepository(this._client);

  Future<PostResponse> getPosts({String tag = "", String filter = ""}) async {
    try {
      var query = <String, String>{};
      if (tag.isNotEmpty) {
        query['tag'] = tag;
      }
      if (filter.isNotEmpty) {
        query['filter'] = filter;
      }
      var response = await _client.get('posts', queryParameters: query);
      return PostResponse.fromJson(response.data);
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

  Future<AddPostResponse> addPost(
      {String body,
      String title,
      List<File> attachments,
      List<String> tags}) async {
    try {
      var data = FormData.from({
        'title': title,
        'post': body,
        'tags': tags,
        'post_attachments': attachments
            .map((attachment) => UploadFileInfo(attachment,
                "attachment${DateTime.now().millisecondsSinceEpoch}"))
            .toList()
      });
      var response = await _client.post('posts', data: data);
      return AddPostResponse.fromJson(response.data);
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

  Future<PostLikeResponse> likePost(int postId) async {
    try {
      var response =
          await _client.post('post_likes', data: {"post_id": postId});
      return PostLikeResponse.fromJson(response.data);
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

  Future<PostLikeResponse> unlikePost(int postId) async {
    try {
      var response =
          await _client.delete('post_likes', data: {"post_id": postId});
      return PostLikeResponse.fromJson(response.data);
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
