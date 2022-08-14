import 'package:feedback24_app/sign_up/sign_up_step1/view/sign_up_step1_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../bloc/sign_up_step1_bloc.dart';

class SignUpStep1Page extends StatelessWidget {
  const SignUpStep1Page({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SignUpStep1Page(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpStep1Bloc(
        userRepository: context.read<UserRepository>(),
      ),
      child: const SignUpStep1Form(),
    );
  }
}
