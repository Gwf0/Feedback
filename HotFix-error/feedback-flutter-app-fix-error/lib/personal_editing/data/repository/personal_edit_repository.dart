import 'package:feedback24_app/personal_editing/data/model/personal_edit.dart';
import 'package:feedback24_app/shared/network/dio_client.dart';
import 'package:feedback24_app/shared/services/locator.dart';

class PersonalEditRepository {
  final network = getIt<DioClient>();

  Future<PersonalEdit> personalResult() async {
    final response = await network.dio.get(
      '/user/profile',
    );
    print(response.data.toString());
    return PersonalEdit.fromJson(response.data);
  }

  Future<void> personalAddResult() async {
    final response = await network.dio.post(
      '/user/profile',
    );
    print(response.data.toString());
  }
}
