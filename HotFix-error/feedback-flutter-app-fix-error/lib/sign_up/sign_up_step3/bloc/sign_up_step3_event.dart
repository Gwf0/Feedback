part of 'sign_up_step3_bloc.dart';

abstract class SignUpStep3Event extends Equatable {
  const SignUpStep3Event();

  @override
  List<Object> get props => [];
}

class Pass1Changed extends SignUpStep3Event {
  final String pass1;
  const Pass1Changed(this.pass1);

  @override
  List<Object> get props => [pass1];
}

class Pass2Changed extends SignUpStep3Event {
  final String pass2;
  const Pass2Changed(this.pass2);

  @override
  List<Object> get props => [pass2];
}

class FormStep3Submitted extends SignUpStep3Event {}
