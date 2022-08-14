part of 'sign_up_step1_bloc.dart';

class SignUpStep1State extends Equatable {
  const SignUpStep1State({
    this.firstname = const FirstName.pure(),
    this.lastname = const LastName.pure(),
    this.phone = const PhoneNumber.pure(),
    this.status = FormzStatus.pure,
  });

  final FirstName firstname;
  final LastName lastname;
  final PhoneNumber phone;
  final FormzStatus status;

  SignUpStep1State copyWith({
    FirstName? firstname,
    LastName? lastname,
    PhoneNumber? phone,
    FormzStatus? status,
  }) {
    return SignUpStep1State(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phone: phone ?? this.phone,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [firstname, lastname, phone, status];
}
