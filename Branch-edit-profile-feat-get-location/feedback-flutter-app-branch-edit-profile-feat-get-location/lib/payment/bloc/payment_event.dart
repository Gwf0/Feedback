part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class PaymentFetchEvent extends PaymentEvent {}

class EditPaymentFetchEvent extends PaymentEvent {
  final String currentAccount;
  final String bik;

  EditPaymentFetchEvent(
    this.currentAccount,
    this.bik,
  );
}
