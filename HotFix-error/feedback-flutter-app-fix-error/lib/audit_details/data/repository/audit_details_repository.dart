import '../../../shared/network/dio_client.dart';
import '../../../shared/services/locator.dart';
import '../model/audit_details_model.dart';

class AuditDetailsRepository {
  final network = getIt<DioClient>();

  Future<AuditDetails> getAuditDetails(
    String auditId,
  ) async {
    final response = await network.dio.get('/v2/audits/$auditId');
    print(response.data.toString());
    return AuditDetails.fromJson(response.data);
  }
}

class AuditInstructionsRepository {
  final network = getIt<DioClient>();

  Future<Instructions> getAuditInstructions(
    String auditId,
  ) async {
    final response = await network.dio.get('/v2/instructions/$auditId');
    print(response.data.toString());
    return Instructions.fromJson(response.data);
  }
}

class AuditShedulRepository {
  final network = getIt<DioClient>();

  Future<Schedule> getAuditShedule(
    String auditId,
  ) async {
    final response = await network.dio.get('/v2/audits/$auditId');
    print(response.data.toString());
    return Schedule.fromJson(response.data);
  }

  Future<Schedule> postAudit(
    String auditId,
  ) async {
    final response = await network.dio.post('/v2/audits/$auditId/bid');
    print(response.data.toString());
    return Schedule.fromJson(response.data);
  }
}
