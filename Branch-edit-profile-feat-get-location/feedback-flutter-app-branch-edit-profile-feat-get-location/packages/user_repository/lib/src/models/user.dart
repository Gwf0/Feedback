import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.signUpStep1,
    required this.signUpStep2,
    required this.signUpStep3,
  });

  final SignUpStep1 signUpStep1;
  final SignUpStep2 signUpStep2;
  final SignUpStep3 signUpStep3;

  factory User.empty() {
    return User(
      signUpStep1: SignUpStep1.empty(),
      signUpStep2: SignUpStep2.empty(),
      signUpStep3: SignUpStep3.empty(),
    );
  }

  User copyWith({
    SignUpStep1? signUpStep1,
    SignUpStep2? signUpStep2,
    SignUpStep3? signUpStep3,
  }) {
    return User(
      signUpStep1: signUpStep1 ?? this.signUpStep1,
      signUpStep2: signUpStep2 ?? this.signUpStep2,
      signUpStep3: signUpStep3 ?? this.signUpStep3,
    );
  }

  @override
  List<Object?> get props => [signUpStep1, signUpStep2, signUpStep3];
}

class SignUpStep1 extends Equatable {
  const SignUpStep1({
    required this.firstname,
    required this.lastname,
    required this.phone,
  });

  final String firstname;
  final String lastname;
  final phone;

  factory SignUpStep1.empty() {
    return const SignUpStep1(
      firstname: '',
      lastname: '',
      phone: '',
    );
  }

  SignUpStep1 copyWith({
    String? firstname,
    String? email,
    String? phone,
  }) {
    return SignUpStep1(
      firstname: firstname ?? this.firstname,
      lastname: lastname,
      phone: phone,
    );
  }

  @override
  List<Object?> get props => [firstname, lastname, phone];
}

class SignUpStep2 extends Equatable {
  const SignUpStep2({
    required this.code,
  });

  final code;

  factory SignUpStep2.empty() {
    return const SignUpStep2(
      code: '',
    );
  }

  SignUpStep2 copyWith({
    String? code,
  }) {
    return SignUpStep2(
      code: code,
    );
  }

  @override
  List<Object?> get props => [code];
}

class SignUpStep3 extends Equatable {
  const SignUpStep3({
    required this.pass1,
    required this.pass2,
  });

  final String pass1;
  final String pass2;

  factory SignUpStep3.empty() {
    return const SignUpStep3(
      pass1: '',
      pass2: '',
    );
  }

  SignUpStep3 copyWith({
    String? pass1,
    String? pass2,
  }) {
    return SignUpStep3(
      pass1: pass1 ?? this.pass1,
      pass2: pass2 ?? this.pass2,
    );
  }

  @override
  List<Object?> get props => [pass1, pass2];
}
