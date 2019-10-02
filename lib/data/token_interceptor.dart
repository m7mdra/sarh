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

import 'package:dio/dio.dart';
import 'session.dart';

class TokenInterceptor extends Interceptor {
  final Session session;

  TokenInterceptor(this.session);

  @override
  onRequest(RequestOptions options) async {
    if (session.token != null && session.token.isNotEmpty) {
      var token = session.token;
      options.headers['authorization'] = 'Bearer $token';
      print("token found.");
    } else
      print("token not found,ignored. probably a guest.");
    return options;
  }
}
