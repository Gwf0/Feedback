import 'dart:math';

import 'package:dio/dio.dart';
import 'package:feedback_api_client/feedback_api_client.dart';
import 'package:fresh_dio/fresh_dio.dart';

class PhotosRequestFailureException implements Exception {}

class FeedbackApiClient {
  FeedbackApiClient({Dio? httpClient})
      : _httpClient = (httpClient ?? Dio())
          ..options.baseUrl = 'https://feedback24.ru/api'
          ..interceptors.add(_fresh)
          ..interceptors.add(
            LogInterceptor(request: false, responseHeader: false),
          );

  static var _refreshCount = 0;
  static final _fresh = Fresh.oAuth2(
    tokenStorage: InMemoryTokenStorage<OAuth2Token>(),
    refreshToken: (token, client) async {
      print('refreshing token...');
      await Future<void>.delayed(const Duration(seconds: 1));
      if (Random().nextInt(3) == 0) {
        print('token revoked!');
        throw RevokeTokenException();
      }
      print('token refreshed!');
      _refreshCount++;
      return OAuth2Token(
        accessToken: 'access_token_$_refreshCount',
        refreshToken: 'refresh_token_$_refreshCount',
      );
    },
    shouldRefresh: (_) => Random().nextInt(3) == 0,
  );

  final Dio _httpClient;

  Stream<AuthenticationStatus> get authenticationStatus =>
      _fresh.authenticationStatus;

  Future<void> authenticate({
    required String phone,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 5));
    await _fresh.setToken(
      const OAuth2Token(
        accessToken: 'initial_access_token',
        refreshToken: 'initial_refresh_token',
      ),
    );
  }

  Future<void> unauthenticate() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    await _fresh.setToken(null);
  }

  Future<List<UserModel>> photos({required Map<String, String> data}) async {
    final response = await _httpClient.get<dynamic>('/UserModel');

    if (response.statusCode != 200) {
      throw PhotosRequestFailureException();
    }

    return (response.data as List)
        .map((dynamic item) => UserModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
