import 'package:feedback24_app/shared/network/dio_client.dart';
import 'package:feedback24_app/shared/services/locator.dart';

import '../model/personal_model.dart';

class PersonalRepository {
  final network = getIt<DioClient>();

  Future<Personal> getUserPersonalDetails() async {
    final response = await network.dio.get(
      '/user/profile',
    );
    print(response.data.toString());
    return Personal.fromJson(response.data);
  }
}
