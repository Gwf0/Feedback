part of 'sign_up_step2_bloc.dart';

class SignUpStep2State extends Equatable {
  const SignUpStep2State({
    this.code = const Code.pure(),
    this.status = FormzStatus.pure,
  });

  final Code code;
  final FormzStatus status;

  SignUpStep2State copyWith({
    FormzStatus? status,
    Code? code,
  }) {
    return SignUpStep2State(
      status: status ?? this.status,
      code: code ?? this.code,
    );
  }

  @override
  List<Object> get props => [status, code];
}
