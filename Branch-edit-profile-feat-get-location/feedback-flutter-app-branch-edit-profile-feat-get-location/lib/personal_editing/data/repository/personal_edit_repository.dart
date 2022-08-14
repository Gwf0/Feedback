import 'package:feedback24_app/personal_editing/data/model/personal_edit.dart';
import 'package:feedback24_app/shared/network/dio_client.dart';
import 'package:feedback24_app/shared/services/locator.dart';
import 'package:dio/dio.dart';

class PersonalEditRepository {
  final network = getIt<DioClient>();

  Future<PersonalEdit> personalResult() async {
    try {
      final response = await network.dio.get(
        '/user/profile',
      );
      print(response.data.toString());
      return PersonalEdit.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
      if (e.type == DioErrorType.response) {
        String errorMessage = e.response!.data['error'];
        throw (errorMessage);
      }
      throw ('Unkown error');
    }
  }

  Future<PersonalEdit> personalAddResult(
    String firstName,
    String lastName,
    String middleName,
    String phone,
    String email,
    int inn,
    City city,
    String sex,
    String education,
    String activity,
    String about,
  ) async {
    try {
      final response = await network.dio.post('/user/profile', data: {
        'first_name': firstName,
        'last_name': lastName,
        'middle_name': middleName,
        'phone': phone,
        'email': email,
        'city': city,
        'sex': sex,
        'education': education,
        'activity': activity,
        'about': about,
        'inn': inn,
      });
      print(response.data.toString());
      return PersonalEdit.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
      if (e.type == DioErrorType.response) {
        String errorMessage = e.response!.data['error'];
        throw (errorMessage);
      }
      throw ('Unkown error');
    }
  }
}
