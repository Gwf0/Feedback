part of 'sign_up_step2_bloc.dart';

abstract class SignUpStep2Event extends Equatable {
  const SignUpStep2Event();

  @override
  List<Object> get props => [];
}

class PostcodeChanged extends SignUpStep2Event {
  final String code;
  const PostcodeChanged(this.code);

  @override
  List<Object> get props => [code];
}

class FormStep2Submitted extends SignUpStep2Event {}
