import 'package:dio/dio.dart';
import 'package:user_repository/user_repository.dart';

class AuthorizationInterceptor extends Interceptor {
  UserRepository user = UserRepository();

  @override
  Future<void> onRequest(options, handler) async {
    final bool hasToken = await user.hasToken();

    if (hasToken) {
      options.headers['Authorization'] = await user.getToken();
    }

    super.onRequest(options, handler);
  }
}
