import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:user_repository/src/model/recovery_model.dart';
import 'package:user_repository/src/model/user_model.dart';
import './model/user_model.dart';
import 'models/user.dart';

class UserRepository {
  static String _baseUrl = 'https://feedback24.ru/api';
  final FlutterSecureStorage _storage = new FlutterSecureStorage();
  final Dio _dio = Dio();
  User? _user;

  Future<User?> getUser() async {
    await Future.delayed(const Duration(seconds: 1));
    return _user ?? User.empty();
  }

  Future<UserModel> signIn({
    required String phone,
    required String password,
  }) async {
    try {
      Response response = await _dio.post('$_baseUrl/v2/auth/login',
          data: {'phone': phone, 'password': password});
      print(response.data);

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.response);
      if (e.type == DioErrorType.response) {
        String errorMessage = e.response!.data['message'];
        throw (errorMessage);
      }
    }
    throw 'Ошибка авторизации';
  }

  Future<void> updateSignUpStep1({
    required String phone,
    required String firstName,
    required String lastName,
  }) async {
    _user ??= User.empty();
    try {
      await _dio.post('$_baseUrl/signup/confirmation', data: {
        'phone': phone,
        'first_name': firstName,
        'last_name': lastName,
        'account_type': 'secretbuyer',
      });
    } on DioError catch (e) {
      print(e.response);
      if (e.type == DioErrorType.response) {
        String errorMessage = e.response!.data['message'];
        throw (errorMessage);
      }
    }
  }

  Future<void> updateSignUpStep2({
    required String phone,
    required code,
  }) async {
    try {
      Response response =
          await _dio.post('$_baseUrl/v2/signup/checkcode', data: {
        'phone': phone,
        'code': code,
      });
      print(response.data);
    } on DioError catch (e) {
      print(e.response);
      if (e.type == DioErrorType.response) {
        String errorMessage = e.response!.data['message'];
        throw (errorMessage);
      }
    }
  }

  Future<UserModel> updateSignUpStep3({
    required String phone,
    required String code,
    required String pass1,
    required String pass2,
  }) async {
    try {
      Response response = await _dio.post('$_baseUrl/v2/signup/finish', data: {
        'phone': phone,
        'code': code,
        'pass1': pass1,
        'pass2': pass2,
      });
      print(response.data);
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['user']);
      }
    } on DioError catch (e) {
      print(e.response);
      if (e.type == DioErrorType.response) {
        String errorMessage = e.response!.data['message'];
        throw (errorMessage);
      }
    }
    throw 'Ошибка ввода пароля';
  }

  Future<bool> hasToken() async {
    final value = await _storage.read(key: 'token');
    return value != null ? true : false;
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> persistToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
    await _storage.deleteAll();
  }

  Future<RecoveryModel> recoveryPass({
    required String email,
  }) async {
    try {
      Response response =
          await _dio.post('$_baseUrl/v2/auth/password/reset', data: {
        'email': email,
      });
      print(response.data);
      if (response.statusCode == 200) {
        return RecoveryModel.fromJson(response.data['user']);
      }
    } on DioError catch (e) {
      print(e.response);
      if (e.type == DioErrorType.response) {
        String errorMessage = e.response!.data['message'];
        throw (errorMessage);
      }
    }
    throw 'Ошибка восстановления';
  }
}
