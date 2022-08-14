import 'package:feedback24_app/shared/network/dio_client.dart';
import 'package:feedback24_app/shared/services/locator.dart';

import '../model/audit_model.dart';

class AuditRepository {
  final network = getIt<DioClient>();

  Future<AuditList> getAudits() async {
    final response = await network.dio.get(
      '/v2/audits',
    );
    print(response.data.toString());
    return AuditList.fromJson(response.data);
  }
}
