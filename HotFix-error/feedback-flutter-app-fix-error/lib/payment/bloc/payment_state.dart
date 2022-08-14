part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final Payment payment;
  const PaymentLoaded({
    required this.payment,
  });
}

class PaymentError extends PaymentState {
  final String message;
  const PaymentError({
    required this.message,
  });
}
