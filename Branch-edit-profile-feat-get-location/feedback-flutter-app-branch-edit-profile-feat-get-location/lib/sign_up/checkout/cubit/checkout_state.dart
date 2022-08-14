part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  const CheckoutState(
      {this.activeStepperIndex = 0,
      this.phone = '',
      this.code = '',
      this.pass1 = '',
      this.pass2 = ''});

  final int activeStepperIndex;
  final String phone;
  final String code;
  final String pass1;
  final String pass2;

  CheckoutState copyWith({
    int? activeStepperIndex,
    String? phone,
    String? code,
    String? pass1,
    String? pass2,
  }) {
    return CheckoutState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
      phone: phone ?? this.phone,
      code: code ?? this.code,
      pass1: pass1 ?? this.pass1,
      pass2: pass2 ?? this.pass2,
    );
  }

  @override
  List<Object> get props => [activeStepperIndex, phone, code, pass1, pass2];
}
