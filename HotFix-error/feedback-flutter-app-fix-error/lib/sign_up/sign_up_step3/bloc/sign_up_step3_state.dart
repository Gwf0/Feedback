part of 'sign_up_step3_bloc.dart';

class SignUpStep3State extends Equatable {
  const SignUpStep3State({
    this.pass1 = const Pass1.pure(),
    this.pass2 = const Pass2.pure(),
    this.status = FormzStatus.pure,
  });

  final Pass1 pass1;
  final Pass2 pass2;
  final FormzStatus status;

  SignUpStep3State copyWith({
    Pass1? pass1,
    Pass2? pass2,
    FormzStatus? status,
  }) {
    return SignUpStep3State(
      pass1: pass1 ?? this.pass1,
      pass2: pass2 ?? this.pass2,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [pass1, pass2, status];
}
