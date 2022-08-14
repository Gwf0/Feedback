import 'package:feedback24_app/quiz/data/model/quiz_model.dart';

import '../../../shared/network/dio_client.dart';
import '../../../shared/services/locator.dart';

class QuizRepository {
  final network = getIt<DioClient>();

  Future<Quiz> quiz(
    String auditId,
  ) async {
    final response =
        await network.dio.get('/reports/$auditId/questions?page=1&count=1');
    print(response.data.toString());
    return Quiz.fromJson(response.data);
  }
}
