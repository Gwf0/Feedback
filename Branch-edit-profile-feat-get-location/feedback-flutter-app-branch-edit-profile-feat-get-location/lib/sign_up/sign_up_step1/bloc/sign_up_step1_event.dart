part of 'sign_up_step1_bloc.dart';

abstract class SignUpStep1SEvent extends Equatable {
  const SignUpStep1SEvent();

  @override
  List<Object> get props => [];
}

class FirstnameChanged extends SignUpStep1SEvent {
  final String firstname;
  const FirstnameChanged(this.firstname);

  @override
  List<Object> get props => [firstname];
}

class LastnameChanged extends SignUpStep1SEvent {
  final String lastname;
  const LastnameChanged(this.lastname);

  @override
  List<Object> get props => [lastname];
}

class PhoneChanged extends SignUpStep1SEvent {
  final String phone;
  const PhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class FormStep1Submitted extends SignUpStep1SEvent {}
