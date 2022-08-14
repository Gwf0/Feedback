import 'package:feedback24_app/shared/network/dio_client.dart';
import 'package:feedback24_app/shared/services/locator.dart';

import '../model/placemark_model.dart';

class MapRepository {
  final network = getIt<DioClient>();

  Future<Coords> getMaps() async {
    final response = await network.dio.get(
      '/v2/audits',
    );
    print(response.data.toString());
    return Coords.fromJson(response.data);
  }
}
