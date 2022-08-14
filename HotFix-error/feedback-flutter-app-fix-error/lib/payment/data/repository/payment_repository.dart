import 'package:feedback24_app/shared/network/dio_client.dart';
import 'package:feedback24_app/shared/services/locator.dart';

import 'package:feedback24_app/payment/data/model/payment_model.dart';

class PaymentRepository {
  final network = getIt<DioClient>();

  Future<Payment> getUserPayment() async {
    final response = await network.dio.get(
      '/user/payment',
    );
    print(response.data.toString());
    return Payment.fromJson(response.data);
  }
}
