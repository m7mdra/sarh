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
