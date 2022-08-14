import 'package:feedback24_app/shared/network/dio_client.dart';
import 'package:feedback24_app/shared/services/locator.dart';
import 'package:dio/dio.dart';

import 'package:feedback24_app/payment/data/model/payment_model.dart';

class PaymentRepository {
  final network = getIt<DioClient>();

  Future<Payment> getUserPayment() async {
    try {
      final response = await network.dio.get(
        '/user/payment',
      );
      print(response.data.toString());
      return Payment.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
      if (e.type == DioErrorType.response) {
        String errorMessage = e.response!.data['error'];
        throw (errorMessage);
      }
      throw ('Unkown error');
    }
  }

  Future<Payment> postUserPayment(String bik, String currentAccount) async {
    try {
      final response = await network.dio.post('/user/payment',
          data: {'bik': bik, 'current_account': currentAccount});
      print(response.data.toString());
      return Payment.fromJson(response.data);
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
