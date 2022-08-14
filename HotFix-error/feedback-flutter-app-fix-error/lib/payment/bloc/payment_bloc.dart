import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedback24_app/payment/data/model/payment_model.dart';
import 'package:feedback24_app/payment/data/repository/payment_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;
  PaymentBloc({required this.paymentRepository}) : super(PaymentInitial()) {
    on<PaymentFetchEvent>(_fetchPayment);
  }

  FutureOr<void> _fetchPayment(
      PaymentFetchEvent event, Emitter<PaymentState> emit) async {
    try {
      emit(PaymentLoading());
      final payment = await paymentRepository.getUserPayment();
      emit(PaymentLoaded(payment: payment));
    } catch (e) {
      emit(PaymentError(message: e.toString()));
    }
  }
}
